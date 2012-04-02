require "spec_helper"

describe PretendersController do
  describe "routing" do

    it "routes to #index" do
      get("/pretenders").should route_to("pretenders#index")
    end

    it "routes to #new" do
      get("/pretenders/new").should route_to("pretenders#new")
    end

    it "routes to #show" do
      get("/pretenders/1").should route_to("pretenders#show", :id => "1")
    end

    it "routes to #edit" do
      get("/pretenders/1/edit").should route_to("pretenders#edit", :id => "1")
    end

    it "routes to #create" do
      post("/pretenders").should route_to("pretenders#create")
    end

    it "routes to #update" do
      put("/pretenders/1").should route_to("pretenders#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/pretenders/1").should route_to("pretenders#destroy", :id => "1")
    end

  end
end
