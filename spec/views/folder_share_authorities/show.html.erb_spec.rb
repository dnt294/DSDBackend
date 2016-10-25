require 'rails_helper'

RSpec.describe "folder_share_authorities/show", type: :view do
  before(:each) do
    @folder_share_authority = assign(:folder_share_authority, FolderShareAuthority.create!(
      :folder => nil,
      :user => nil,
      :can_create => false,
      :can_view => false,
      :can_update => false,
      :can_destroy => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
