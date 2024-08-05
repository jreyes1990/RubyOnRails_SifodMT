require "rails_helper"

RSpec.describe DatosApisController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/datos_apis").to route_to("datos_apis#index")
    end

    it "routes to #new" do
      expect(get: "/datos_apis/new").to route_to("datos_apis#new")
    end

    it "routes to #show" do
      expect(get: "/datos_apis/1").to route_to("datos_apis#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/datos_apis/1/edit").to route_to("datos_apis#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/datos_apis").to route_to("datos_apis#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/datos_apis/1").to route_to("datos_apis#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/datos_apis/1").to route_to("datos_apis#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/datos_apis/1").to route_to("datos_apis#destroy", id: "1")
    end
  end
end
