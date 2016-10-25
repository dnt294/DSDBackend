class AddUploaderToUpFiles < ActiveRecord::Migration[5.0]
    def change
        add_reference :up_files, :uploader, references: :users, index: true, null: false
        add_foreign_key :up_files, :users, column: :uploader_id
    end
end
