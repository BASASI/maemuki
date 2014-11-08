class ChangeTypeOldestId < ActiveRecord::Migration
  def change
    change_column :identities, :oldest_id, :integer, limit: 8
  end
end
