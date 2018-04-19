class AddCounterCacheToManagers < ActiveRecord::Migration[5.2]
  def change
    add_column :managers, :bands_count, :integer, default: 0

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
      UPDATE managers
         SET bands_count = (
             SELECT count(1) FROM bands
             WHERE bands.manager_id = managers.id
         );
    SQL
  end
end
