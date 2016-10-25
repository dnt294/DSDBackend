require 'rails_helper'

RSpec.describe "up_file_shortcuts/show", type: :view do
  before(:each) do
    @up_file_shortcut = assign(:up_file_shortcut, UpFileShortcut.create!(
      :up_file => nil,
      :folder => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
