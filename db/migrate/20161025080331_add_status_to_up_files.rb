class AddStatusToUpFiles < ActiveRecord::Migration[5.0]
  def change
    add_column :up_files, :status, :string
  end
end
