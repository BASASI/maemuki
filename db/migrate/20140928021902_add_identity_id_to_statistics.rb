class AddIdentityIdToStatistics < ActiveRecord::Migration
  def change
    add_column :statistics, :identity_id, :integer
  end
end
