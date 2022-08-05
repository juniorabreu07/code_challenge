require "rails_helper"

RSpec.describe BuiesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/buies").to route_to("buies#index" )
    end

    it "routes to #show" do
      expect(get: "/buies/1").to route_to("buies#show", id: "1" )
    end

    it "routes to #create" do
      expect(post: "/buies").to route_to("buies#create" )
    end

    it "routes to #update via PUT" do
      expect(put: "/buies/1").to route_to("buies#update", id: "1" )
    end

    it "routes to #update via PATCH" do
      expect(patch: "/buies/1").to route_to("buies#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/buies/1").to route_to("buies#destroy", id: "1")
    end
  end
end