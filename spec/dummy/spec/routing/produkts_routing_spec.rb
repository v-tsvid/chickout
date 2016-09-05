require "rails_helper"

RSpec.describe ProduktsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/produkts").to route_to("produkts#index")
    end

    it "routes to #new" do
      expect(:get => "/produkts/new").to route_to("produkts#new")
    end

    it "routes to #show" do
      expect(:get => "/produkts/1").to route_to("produkts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/produkts/1/edit").to route_to("produkts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/produkts").to route_to("produkts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/produkts/1").to route_to("produkts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/produkts/1").to route_to("produkts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/produkts/1").to route_to("produkts#destroy", :id => "1")
    end

  end
end
