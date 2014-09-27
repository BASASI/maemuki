class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :uid
      t.string :provider
      t.string :token
      t.datetime :expires_at
      t.string :secret

      t.timestamps
    end
  end
end
