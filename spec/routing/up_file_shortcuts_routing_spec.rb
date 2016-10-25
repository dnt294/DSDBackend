require "rails_helper"

RSpec.describe UpFileShortcutsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/up_file_shortcuts").to route_to("up_file_shortcuts#index")
    end

    it "routes to #new" do
      expect(:get => "/up_file_shortcuts/new").to route_to("up_file_shortcuts#new")
    end

    it "routes to #show" do
      expect(:get => "/up_file_shortcuts/1").to route_to("up_file_shortcuts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/up_file_shortcuts/1/edit").to route_to("up_file_shortcuts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/up_file_shortcuts").to route_to("up_file_shortcuts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/up_file_shortcuts/1").to route_to("up_file_shortcuts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/up_file_shortcuts/1").to route_to("up_file_shortcuts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/up_file_shortcuts/1").to route_to("up_file_shortcuts#destroy", :id => "1")
    end

  end
end
