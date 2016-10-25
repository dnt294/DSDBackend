class AddFolderShortcuts < ActiveRecord::Migration[5.0]
  def change
  	create_table :folder_shortcuts do |t|
  		t.integer :shortcut_id
  		t.integer :destination_id
  		
  		t.timestamps
  	end

  	add_index :folder_shortcuts, :shortcut_id
  	add_index :folder_shortcuts, :destination_id
  	add_index :folder_shortcuts, [:shortcut_id, :destination_id], unique: true
  end
end
