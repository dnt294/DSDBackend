class AddTempUpIdToUpFiles < ActiveRecord::Migration[5.0]
  def change
    add_column :up_files, :temp_up_id, :string, index: true
  end
end
