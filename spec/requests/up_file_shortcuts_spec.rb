require 'rails_helper'

RSpec.describe "UpFileShortcuts", type: :request do
  describe "GET /up_file_shortcuts" do
    it "works! (now write some real specs)" do
      get up_file_shortcuts_path
      expect(response).to have_http_status(200)
    end
  end
end
