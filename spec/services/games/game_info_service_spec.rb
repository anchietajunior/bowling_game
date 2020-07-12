require 'rails_helper'

RSpec.describe Games::GameInfoService do

  describe '#call' do

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