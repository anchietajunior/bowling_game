require 'rails_helper'

RSpec.describe Games::ScoreCalculatorService do

  describe '#call' do
    context 'with 3 frames' do

      let!(:game) { create(:game) }
      let!(:frame1) { create(:frame, game: game) }
      let!(:frame2) { create(:frame, game: game) }
      let!(:frame3) { create(:frame, game: game) }

      let!(:attempt11) { create(:attempt, overtuned_pins: 3, points: 3, frame: frame1) }
      let!(:attempt12) { create(:attempt, overtuned_pins: 3, points: 4, frame: frame1) }

      let!(:attempt21) { create(:attempt, overtuned_pins: 3, points: 3, frame: frame2) }
      let!(:attempt22) { create(:attempt, overtuned_pins: 3, points: 7, frame: frame2) }

      let!(:attempt31) { create(:attempt, overtuned_pins: 3, points: 2, frame: frame3) }
      let!(:attempt32) { create(:attempt, overtuned_pins: 3, points: 5, frame: frame3) }

      let(:service) do
        described_class.call(game)
      end

      it 'has a score with 24 points' do
        expect(service.value).to eq(24)
      end

    end
  end

end