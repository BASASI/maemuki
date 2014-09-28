class AddLatestIdAndOldestIdToIdentities < ActiveRecord::Migration
  def change
    add_column :identities, :latest_id, :integer
    add_column :identities, :oldest_id, :integer
  end
end
