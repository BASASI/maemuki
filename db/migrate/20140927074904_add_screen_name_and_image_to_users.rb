class AddScreenNameAndImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :screen_name, :string
    add_column :users, :image, :string
    add_index :users, :name
  end
end
