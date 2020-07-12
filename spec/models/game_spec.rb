require 'rails_helper'

RSpec.describe Game, type: :model do

  describe 'relationships' do
    it { is_expected.to have_many :frames }
  end
end
