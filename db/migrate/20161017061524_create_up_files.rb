class CreateUpFiles < ActiveRecord::Migration[5.0]
    def change
        create_table :up_files do |t|
            t.string :link
            t.string :file_name
            t.string :file_type
            t.integer :file_size            

            t.timestamps
        end
    end
end
