require 'rails_helper'

RSpec.describe "up_files/index", type: :view do
  before(:each) do
    assign(:up_files, [
      UpFile.create!(
        :link => "Link",
        :name => "Name",
        :folder => nil
      ),
      UpFile.create!(
        :link => "Link",
        :name => "Name",
        :folder => nil
      )
    ])
  end

  it "renders a list of up_files" do
    render
    assert_select "tr>td", :text => "Link".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end