require 'rails_helper'

RSpec.describe "up_file_share_authorities/new", type: :view do
  before(:each) do
    assign(:up_file_share_authority, UpFileShareAuthority.new(
      :up_file => nil,
      :user => nil,
      :can_create => false,
      :can_view => false,
      :can_update => false,
      :can_destroy => false
    ))
  end

  it "renders new up_file_share_authority form" do
    render

    assert_select "form[action=?][method=?]", up_file_share_authorities_path, "post" do

      assert_select "input#up_file_share_authority_up_file_id[name=?]", "up_file_share_authority[up_file_id]"

      assert_select "input#up_file_share_authority_user_id[name=?]", "up_file_share_authority[user_id]"

      assert_select "input#up_file_share_authority_can_create[name=?]", "up_file_share_authority[can_create]"

      assert_select "input#up_file_share_authority_can_view[name=?]", "up_file_share_authority[can_view]"

      assert_select "input#up_file_share_authority_can_update[name=?]", "up_file_share_authority[can_update]"

      assert_select "input#up_file_share_authority_can_destroy[name=?]", "up_file_share_authority[can_destroy]"
    end
  end
end
