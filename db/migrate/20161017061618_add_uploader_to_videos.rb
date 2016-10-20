class AddUploaderToVideos < ActiveRecord::Migration[5.0]
    def change
        add_reference :videos, :uploader, references: :users, index: true
        add_foreign_key :videos, :users, column: :uploader_id
    end
end
