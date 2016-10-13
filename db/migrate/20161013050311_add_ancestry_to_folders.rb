class AddAncestryToFolders < ActiveRecord::Migration[5.0]
  def change
    add_column :folders, :ancestry, :text
  end
end
