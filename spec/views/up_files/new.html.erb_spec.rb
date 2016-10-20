require 'rails_helper'

RSpec.describe "up_files/new", type: :view do
  before(:each) do
    assign(:up_file, UpFile.new(
      :link => "MyString",
      :name => "MyString",
      :folder => nil
    ))
  end

  it "renders new up_file form" do
    render

    assert_select "form[action=?][method=?]", up_files_path, "post" do

      assert_select "input#up_file_link[name=?]", "up_file[link]"

      assert_select "input#up_file_name[name=?]", "up_file[name]"

      assert_select "input#up_file_folder_id[name=?]", "up_file[folder_id]"
    end
  end
end