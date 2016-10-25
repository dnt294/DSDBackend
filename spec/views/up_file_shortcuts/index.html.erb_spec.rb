require 'rails_helper'

RSpec.describe "up_file_shortcuts/index", type: :view do
  before(:each) do
    assign(:up_file_shortcuts, [
      UpFileShortcut.create!(
        :up_file => nil,
        :folder => nil
      ),
      UpFileShortcut.create!(
        :up_file => nil,
        :folder => nil
      )
    ])
  end

  it "renders a list of up_file_shortcuts" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
