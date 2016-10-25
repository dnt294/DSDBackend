require 'rails_helper'

RSpec.describe "up_file_shortcuts/edit", type: :view do
  before(:each) do
    @up_file_shortcut = assign(:up_file_shortcut, UpFileShortcut.create!(
      :up_file => nil,
      :folder => nil
    ))
  end

  it "renders the edit up_file_shortcut form" do
    render

    assert_select "form[action=?][method=?]", up_file_shortcut_path(@up_file_shortcut), "post" do

      assert_select "input#up_file_shortcut_up_file_id[name=?]", "up_file_shortcut[up_file_id]"

      assert_select "input#up_file_shortcut_folder_id[name=?]", "up_file_shortcut[folder_id]"
    end
  end
end
