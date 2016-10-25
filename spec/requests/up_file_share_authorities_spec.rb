require 'rails_helper'

RSpec.describe "UpFileShareAuthorities", type: :request do
  describe "GET /up_file_share_authorities" do
    it "works! (now write some real specs)" do
      get up_file_share_authorities_path
      expect(response).to have_http_status(200)
    end
  end
end
