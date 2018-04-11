class AddReleaseDateToRecordings < ActiveRecord::Migration[5.1]
  def change
    add_column :recordings, :release_at, :datetime
  end
end
