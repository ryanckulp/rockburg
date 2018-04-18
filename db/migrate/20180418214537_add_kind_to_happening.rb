class AddKindToHappening < ActiveRecord::Migration[5.2]
  def change
    add_column :happenings, :kind, :string
  end
end
