require 'rails_helper'

RSpec.describe Attempts::PointsCalculatorService do

  describe '#call' do
    context 'first attempt of the game' do
      let!(:game)  { create(:game) }
      let!(:frame) { create(:frame, game: game) }

      let(:service) do
        described_class.call(4, frame)
      end

      it 'has 4 points' do
        expect(service.value).to eq(4)
      end
    end

    context 'second attempt of the game without a strike in the same frame' do
      let!(:game)  { create(:game) }
      let!(:frame) { create(:frame, game: game) }
      let!(:attempt1) { create(:attempt, frame: frame, overtuned_pins: 5, points: 5) }

      let(:service) do
        described_class.call(4, frame)
      end

      it 'has 4 points' do
        expect(service.value).to eq(4)
      end
    end

    context 'second attempt of the game with a strike in the same frame' do
      let!(:game)  { create(:game) }
      let!(:frame) { create(:frame, game: game) }
      let!(:attempt1) { create(:attempt, frame: frame, overtuned_pins: 10, points: 10) }

      let(:service) do
        described_class.call(4, frame)
      end

      it 'has 8 points' do
        expect(service.value).to eq(8)
      end
    end

    context 'third attempt of the game without a strike in the last frame' do
      let!(:game)  { create(:game) }
      let!(:frame) { create(:frame, game: game) }
      let!(:attempt1) { create(:attempt, frame: frame, overtuned_pins: 4, points: 4) }
      let!(:attempt2) { create(:attempt, frame: frame, overtuned_pins: 7, points: 7) }

      let(:service) do
        described_class.call(4, frame)
      end

      it 'has 4 points' do
        expect(service.value).to eq(4)
      end
    end

    context 'third attempt of the game with a strike in the last frame' do
      let!(:game)  { create(:game) }
      let!(:frame) { create(:frame, game: game) }
      let!(:attempt1) { create(:attempt, frame: frame, overtuned_pins: 10, points: 10) }

      let(:service) do
        described_class.call(8, frame)
      end

      it 'has 16 points' do
        expect(service.value).to eq(16)
      end
    end

    context 'second attempt of the last frame without a strike in current frame' do
      let!(:game)  { create(:game) }
      let!(:frames) { FactoryBot.create_list(:frame, 10, game: game) }
      let!(:attempt1) { create(:attempt, frame: frames.last, overtuned_pins: 2, points: 2) }

      let(:service) do
        described_class.call(8, frames.last)
      end

      it 'has 8 points' do
        expect(service.value).to eq(8)
      end
    end

    context 'third attempt of the last frame with a strike in current frame' do
      let!(:game)  { create(:game) }
      let!(:frames) { FactoryBot.create_list(:frame, 10, game: game) }
      let!(:attempt1) { create(:attempt, frame: frames.last, overtuned_pins: 10, points: 10) }
      let!(:attempt2) { create(:attempt, frame: frames.last, overtuned_pins: 7, points: 7) }

      let(:service) do
        described_class.call(8, frames.last)
      end

      it 'has 8 points' do
        expect(service.value).to eq(8)
      end
    end
  end

end