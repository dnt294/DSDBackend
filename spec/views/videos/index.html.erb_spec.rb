require 'rails_helper'

RSpec.describe "videos/index", type: :view do
  before(:each) do
    assign(:videos, [
      Video.create!(
        :link => "Link",
        :name => "Name",
        :folder => nil
      ),
      Video.create!(
        :link => "Link",
        :name => "Name",
        :folder => nil
      )
    ])
  end

  it "renders a list of videos" do
    render
    assert_select "tr>td", :text => "Link".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
