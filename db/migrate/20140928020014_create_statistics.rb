class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.date :date
      t.integer :positive_count
      t.integer :negative_count

      t.timestamps
    end
  end
end
