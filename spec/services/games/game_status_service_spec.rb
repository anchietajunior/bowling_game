require 'rails_helper'

RSpec.describe Games::GameStatusService do

  let!(:game) { create(:game) }

  let(:service) do
    described_class.call(game)
  end

  describe '#call' do
    it 'has a status in_progress' do
      expect(service.value).to eq({ id: game.id, status: "in_progress" })
    end
  end 

end