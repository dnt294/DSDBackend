require 'rails_helper'

RSpec.describe "up_file_shortcuts/new", type: :view do
  before(:each) do
    assign(:up_file_shortcut, UpFileShortcut.new(
      :up_file => nil,
      :folder => nil
    ))
  end

  it "renders new up_file_shortcut form" do
    render

    assert_select "form[action=?][method=?]", up_file_shortcuts_path, "post" do

      assert_select "input#up_file_shortcut_up_file_id[name=?]", "up_file_shortcut[up_file_id]"

      assert_select "input#up_file_shortcut_folder_id[name=?]", "up_file_shortcut[folder_id]"
    end
  end
end
