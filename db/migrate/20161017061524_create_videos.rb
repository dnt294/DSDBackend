class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :link
      t.string :name
      t.references :folder, foreign_key: true

      t.timestamps
    end
  end
end
