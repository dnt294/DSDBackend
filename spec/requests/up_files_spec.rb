require 'rails_helper'

RSpec.describe "UpFiles", type: :request do
    describe "GET /up_files" do
        it "works! (now write some real specs)" do
            get up_files_path
            expect(response).to have_http_status(200)
        end
    end
end
