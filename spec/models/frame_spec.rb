require 'rails_helper'

RSpec.describe Frame, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many :attempts }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :game }
    it { is_expected.to validate_presence_of :number }
  end
end
