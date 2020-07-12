require 'rails_helper'

RSpec.describe Games::GameStatusService do

  describe '#call' do
    context 'in_progress' do

      let!(:game) { create(:game) }
      let!(:frames) { FactoryBot.create_list(:frame, 3, game_id: game.id) }
     
      let(:service) do
        described_class.call(game)
      end
      
      it 'is a game in_progress' do
        expect(service.value[:status]).to eq("in_progress")
      end
    end

    context 'finished' do

      let!(:game) { create(:game) }
      let!(:frames) { FactoryBot.create_list(:frame, 10, game: game) }
      let!(:attempts) { FactoryBot.create_list(:attempt, 3, frame: frames.last) }
     
      let(:service) do
        described_class.call(game)
      end
      
      it 'is a game in_finished' do
        expect(service.value[:status]).to eq("finished")
      end
    end

    context 'attempts' do

      let!(:game) { create(:game) }
      let!(:frames) { FactoryBot.create_list(:frame, 7, game_id: game.id) }
      let!(:attempts) do
        frames.each do |frame|
          Attempt.create!(frame: frame, overtuned_pins: rand(1..9))
          Attempt.create!(frame: frame, overtuned_pins: rand(1..9))
        end
      end

      let(:service) do
        described_class.call(game)
      end

      it 'has 7 frames' do
        expect(service.value.dig(:frames).count).to eq(7)
      end
    end
  end 

end