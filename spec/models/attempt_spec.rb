require 'rails_helper'

RSpec.describe Attempt, type: :model do
  describe 'validations' do
    
  end
  
  describe 'relationships' do
    it { is_expected.to belong_to :frame }
  end
end
