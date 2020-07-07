require 'rails_helper'

RSpec.describe Game, type: :model do

  describe 'relationships' do
    it { is_expected.to have_many :frames }
  end

  describe 'frames quantity' do
    let!(:game)  { create(:game) }
    let!(:frames) { FactoryBot.create_list(:frame, 10, game_id: game.id) }

    it 'can not have more than 10 fames' do
      p game.frames.count
      expect(Frame.create!(number: 2, game_id: game.id)).to be_falsey
    end
  end
end
