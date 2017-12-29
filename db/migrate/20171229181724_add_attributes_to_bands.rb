class AddAttributesToBands < ActiveRecord::Migration[5.1]
  def change
    add_column :bands, :fans, :integer, default: 0
    add_column :bands, :buzz, :integer, default: 0
  end
end
