class AddCountToStatistics < ActiveRecord::Migration
  def change
    add_column :statistics, :count, :integer, default: 0
    change_column :statistics, :positive_count, :integer, default: 0
    change_column :statistics, :negative_count, :integer, default: 0
  end
end
