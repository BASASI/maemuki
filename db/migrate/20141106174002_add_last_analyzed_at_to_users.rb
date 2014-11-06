class AddLastAnalyzedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_analyzed_at, :datetime
  end
end
