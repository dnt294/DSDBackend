class AddCreatorToFolders < ActiveRecord::Migration[5.0]
    def change
        add_reference :folders, :creator, references: :users, index: true
        add_foreign_key :folders, :users, column: :creator_id
    end
end
