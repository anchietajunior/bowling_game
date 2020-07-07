require "rails_helper"

RSpec.describe AttemptsController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(post: "/attempts").to route_to("attempts#create")
    end
  end
end
