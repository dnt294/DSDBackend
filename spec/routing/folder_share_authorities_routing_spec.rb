require "rails_helper"

RSpec.describe FolderShareAuthoritiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/folder_share_authorities").to route_to("folder_share_authorities#index")
    end

    it "routes to #new" do
      expect(:get => "/folder_share_authorities/new").to route_to("folder_share_authorities#new")
    end

    it "routes to #show" do
      expect(:get => "/folder_share_authorities/1").to route_to("folder_share_authorities#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/folder_share_authorities/1/edit").to route_to("folder_share_authorities#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/folder_share_authorities").to route_to("folder_share_authorities#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/folder_share_authorities/1").to route_to("folder_share_authorities#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/folder_share_authorities/1").to route_to("folder_share_authorities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/folder_share_authorities/1").to route_to("folder_share_authorities#destroy", :id => "1")
    end

  end
end
