require 'rails_helper'

RSpec.describe "videos/edit", type: :view do
  before(:each) do
    @video = assign(:video, Video.create!(
      :link => "MyString",
      :name => "MyString",
      :folder => nil
    ))
  end

  it "renders the edit video form" do
    render

    assert_select "form[action=?][method=?]", video_path(@video), "post" do

      assert_select "input#video_link[name=?]", "video[link]"

      assert_select "input#video_name[name=?]", "video[name]"

      assert_select "input#video_folder_id[name=?]", "video[folder_id]"
    end
  end
end
