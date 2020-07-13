require 'rails_helper'

RSpec.describe Attempts::AttemptCreatorService do

  describe '#call' do
    context 'create attempt in the same frame' do
      let!(:game)    { create(:game) }
      let!(:frame)   { create(:frame, game: game) }
      let!(:attempt) { create(:attempt, frame: frame, overtuned_pins: 3) }

      let(:params) do
        {
          game_id: game.id,
          overtuned_pins: 4
        }
      end

      let(:service) do
        described_class.call(params)
      end

      it 'has a frame with 2 attempts' do
        service
        expect(frame.attempts.count).to eq(2)
      end
    end

    context 'create attempt in a new frame' do
      let!(:game)    { create(:game) }
      let!(:frame)   { create(:frame, game: game) }
      let!(:attempt1) { create(:attempt, frame: frame, overtuned_pins: 4, points: 4) }
      let!(:attempt2) { create(:attempt, frame: frame, overtuned_pins: 5, points: 5) }

      let(:params) do
        {
          game_id: game.id,
          overtuned_pins: 7
        }
      end

      let(:service) do
        described_class.call(params)
      end

      it 'last frame has 1 attempt' do
        p service
        expect(game.frames.last.attempts.count).to eq(1)
        expect(game.frames.count).to eq(2)
      end
    end

    context 'create attempt in the tenth frame' do
      let!(:game)     { create(:game) }
      let!(:frames) { FactoryBot.create_list(:frame, 10, game: game) }
      
      let!(:attempts) do
        frames.each_with_index do |frame, index|
          Attempt.create!(frame: frame, overtuned_pins: 4, points: 4)
          Attempt.create!(frame: frame, overtuned_pins: 4, points: 4) if index < 9
        end
      end

      let(:params) do
        {
          game_id: game.id,
          overtuned_pins: 7
        }
      end

      let(:service) do
        described_class.call(params)
      end

      it 'last frame has 1 attempt' do
        service
        expect(game.frames.count).to eq(10)
        expect(game.frames.last.attempts.count).to eq(2)
      end
    end

    context 'can not create attempt in the tenth frame' do
      let!(:game)     { create(:game) }
      let!(:frames) { FactoryBot.create_list(:frame, 10, game: game) }
      
      let!(:attempts) do
        frames.each_with_index do |frame, index|
          Attempt.create!(frame: frame, overtuned_pins: 4, points: 4)
          Attempt.create!(frame: frame, overtuned_pins: 4, points: 4)
        end
      end

      let(:params) do
        {
          game_id: game.id,
          overtuned_pins: 7
        }
      end

      let(:service) do
        described_class.call(params)
      end

      it 'is not allowed to create a third attempt when the last frame does not have a strike' do
        expect(service.success?).to be_falsey
      end
    end

    context 'can create attempt in the tenth frame' do
      let!(:game)     { create(:game) }
      let!(:frames) { FactoryBot.create_list(:frame, 10, game: game) }
      
      let!(:attempts) do
        frames.each_with_index do |frame, index|
          Attempt.create!(frame: frame, overtuned_pins: 10, points: 10) if index == 9
          Attempt.create!(frame: frame, overtuned_pins: 4, points: 4)
        end
      end

      let(:params) do
        {
          game_id: game.id,
          overtuned_pins: 7
        }
      end

      let(:service) do
        described_class.call(params)
      end

      it 'is allowed to create a third attempt when the last frame has a strike' do
        p service
        expect(game.frames.last.attempts.count).to eq(3)
      end
    end
  end
end