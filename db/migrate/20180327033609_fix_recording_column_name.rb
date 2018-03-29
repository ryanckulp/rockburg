class FixRecordingColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :recordings, :type, :kind
  end
end
