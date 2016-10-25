require 'rails_helper'

RSpec.describe "up_file_share_authorities/index", type: :view do
  before(:each) do
    assign(:up_file_share_authorities, [
      UpFileShareAuthority.create!(
        :up_file => nil,
        :user => nil,
        :can_create => false,
        :can_view => false,
        :can_update => false,
        :can_destroy => false
      ),
      UpFileShareAuthority.create!(
        :up_file => nil,
        :user => nil,
        :can_create => false,
        :can_view => false,
        :can_update => false,
        :can_destroy => false
      )
    ])
  end

  it "renders a list of up_file_share_authorities" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
