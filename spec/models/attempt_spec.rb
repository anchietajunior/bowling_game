require 'rails_helper'

RSpec.describe Attempt, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :frame }
    it { is_expected.to validate_presence_of :overtuned_pins }
  end
  
  describe 'relationships' do
    it { is_expected.to belong_to :frame }
  end
end
