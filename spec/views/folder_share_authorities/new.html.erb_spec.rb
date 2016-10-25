require 'rails_helper'

RSpec.describe "folder_share_authorities/new", type: :view do
  before(:each) do
    assign(:folder_share_authority, FolderShareAuthority.new(
      :folder => nil,
      :user => nil,
      :can_create => false,
      :can_view => false,
      :can_update => false,
      :can_destroy => false
    ))
  end

  it "renders new folder_share_authority form" do
    render

    assert_select "form[action=?][method=?]", folder_share_authorities_path, "post" do

      assert_select "input#folder_share_authority_folder_id[name=?]", "folder_share_authority[folder_id]"

      assert_select "input#folder_share_authority_user_id[name=?]", "folder_share_authority[user_id]"

      assert_select "input#folder_share_authority_can_create[name=?]", "folder_share_authority[can_create]"

      assert_select "input#folder_share_authority_can_view[name=?]", "folder_share_authority[can_view]"

      assert_select "input#folder_share_authority_can_update[name=?]", "folder_share_authority[can_update]"

      assert_select "input#folder_share_authority_can_destroy[name=?]", "folder_share_authority[can_destroy]"
    end
  end
end
