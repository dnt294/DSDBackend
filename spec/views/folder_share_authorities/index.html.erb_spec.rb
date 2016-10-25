require 'rails_helper'

RSpec.describe "folder_share_authorities/index", type: :view do
  before(:each) do
    assign(:folder_share_authorities, [
      FolderShareAuthority.create!(
        :folder => nil,
        :user => nil,
        :can_create => false,
        :can_view => false,
        :can_update => false,
        :can_destroy => false
      ),
      FolderShareAuthority.create!(
        :folder => nil,
        :user => nil,
        :can_create => false,
        :can_view => false,
        :can_update => false,
        :can_destroy => false
      )
    ])
  end

  it "renders a list of folder_share_authorities" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
