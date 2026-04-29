class AddUniqueIndexToDailyStatistics < ActiveRecord::Migration[8.1]
  def change
    add_index :daily_statistics, [:date, :subject], unique: true
  end
end
