require 'rails_helper'

RSpec.describe "/attempts", type: :request do

  let!(:game) { create(:game) }
  
  let(:valid_attributes) do
    { game_id: game.id, overtuned_pins: 5 }
  end

  let(:invalid_attributes) do
    { game_id: nil, overtuned_pins: 3 }
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Attempt" do
        expect {
          post attempts_url,
               params: { attempt: valid_attributes }, headers: {}, as: :json
        }.to change(Attempt, :count).by(1)
      end
    end
  end
end
