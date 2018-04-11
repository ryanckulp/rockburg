class AddWeightToStudios < ActiveRecord::Migration[5.1]
  def change
    add_column :studios, :weight, :integer, default: 0
  end
end
