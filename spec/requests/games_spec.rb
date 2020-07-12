require 'rails_helper'

RSpec.describe "/games", type: :request do

  let!(:game) { create(:game) }
  
  describe "GET /show" do
    it "renders a successful response" do
      get game_url(game.id), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    it "creates a new Game" do
      expect {post games_url, params: {  }, headers: {}, as: :json}.to change(Game, :count).by(1)
    end

    it "renders a JSON response with the new game" do
      post games_url,
            params: {}, headers: {}, as: :json
      expect(response).to have_http_status(:created)
      p response.body
      # expect(response.content_type).to match(a_string_including("status"))
    end

  end
end
