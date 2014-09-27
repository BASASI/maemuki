class AddImageToIdentities < ActiveRecord::Migration
  def change
    add_column :identities, :image, :string
    add_column :identities, :user_id, :integer
    add_index :identities, :uid
    add_index :identities, [:uid, :provider]
    add_index :identities, [:user_id, :provider]
  end
end
