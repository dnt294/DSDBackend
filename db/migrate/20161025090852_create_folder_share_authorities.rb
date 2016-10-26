class CreateFolderShareAuthorities < ActiveRecord::Migration[5.0]
  def change
    create_table :folder_share_authorities do |t|
      t.references :folder, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :can_create, default: true
      t.boolean :can_view, default: true
      t.boolean :can_rename, default: false
      t.boolean :can_move, default: false
      t.boolean :can_destroy, default: false
      t.boolean :direct_share, default: false
      
      t.timestamps
    end
  end
end
