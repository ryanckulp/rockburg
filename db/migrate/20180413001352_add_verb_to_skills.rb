class AddVerbToSkills < ActiveRecord::Migration[5.2]
  def change
    add_column :skills, :verb, :string, default: 'play'
  end
end
