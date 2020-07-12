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
        expect(service.value).to eq("in_progress")
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
        expect(service.value).to eq("finished")
      end
    end
  end

end