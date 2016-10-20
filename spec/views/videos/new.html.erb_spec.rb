require 'rails_helper'

RSpec.describe "videos/new", type: :view do
  before(:each) do
    assign(:video, Video.new(
      :link => "MyString",
      :name => "MyString",
      :folder => nil
    ))
  end

  it "renders new video form" do
    render

    assert_select "form[action=?][method=?]", videos_path, "post" do

      assert_select "input#video_link[name=?]", "video[link]"

      assert_select "input#video_name[name=?]", "video[name]"

      assert_select "input#video_folder_id[name=?]", "video[folder_id]"
    end
  end
end
