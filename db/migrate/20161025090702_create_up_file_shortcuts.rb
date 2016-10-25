class CreateUpFileShortcuts < ActiveRecord::Migration[5.0]
  def change
    create_table :up_file_shortcuts do |t|
      t.references :up_file, foreign_key: true
      t.references :folder, foreign_key: true
      t.boolean :shortcut, default: false
      
      t.timestamps
    end
  end
end
