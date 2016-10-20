require 'rails_helper'

RSpec.describe "up_files/edit", type: :view do
  before(:each) do
    @up_file = assign(:up_file, UpFile.create!(
      :link => "MyString",
      :name => "MyString",
      :folder => nil
    ))
  end

  it "renders the edit up_file form" do
    render

    assert_select "form[action=?][method=?]", up_file_path(@up_file), "post" do

      assert_select "input#up_file_link[name=?]", "up_file[link]"

      assert_select "input#up_file_name[name=?]", "up_file[name]"

      assert_select "input#up_file_folder_id[name=?]", "up_file[folder_id]"
    end
  end
end