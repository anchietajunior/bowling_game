require 'rails_helper'

RSpec.describe Frames::CurrentFrameService do

  describe '#call' do
    context 'first attempt is a strike' do

      let!(:game)    { create(:game) }
      let!(:frame)   { create(:frame, game: game) }
      let!(:attempt) { create(:attempt, frame: frame, overtuned_pins: 10) } 

      let(:service) do
        described_class.call(game)
      end

      it 'returns the second frame' do
        expect(service.value.is_a?(Frame)).to be_truthy
        expect(service.value).not_to eq(frame)
        expect(game.frames.count).to eq(2)
      end
    end

    context 'first attempt was not a strike' do
      
      let!(:game)    { create(:game) }
      let!(:frame)   { create(:frame, game: game) }
      let!(:attempt) { create(:attempt, frame: frame, overtuned_pins: 2) } 

      let(:service) do
        described_class.call(game)
      end

      it 'returns the second frame' do
        expect(service.value.is_a?(Frame)).to be_truthy
        expect(service.value).to eq(frame)
        expect(game.frames.count).to eq(1)
      end
    end
  end
end