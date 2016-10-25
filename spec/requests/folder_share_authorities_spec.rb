require 'rails_helper'

RSpec.describe "FolderShareAuthorities", type: :request do
  describe "GET /folder_share_authorities" do
    it "works! (now write some real specs)" do
      get folder_share_authorities_path
      expect(response).to have_http_status(200)
    end
  end
end
