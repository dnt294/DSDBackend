require 'rails_helper'

RSpec.describe "up_files/show", type: :view do
  before(:each) do
    @up_file = assign(:up_file, UpFile.create!(
      :link => "Link",
      :name => "Name",
      :folder => nil
    ))
  end

  it "renders attributes in 
<p>" do
    render
    expect(rendered).to match(/Link/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end