class AddSalesToRecordings < ActiveRecord::Migration[5.1]
  def change
    add_column :recordings, :sales, :integer, default: 0
  end
end
