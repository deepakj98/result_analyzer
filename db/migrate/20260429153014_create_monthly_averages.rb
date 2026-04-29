class CreateMonthlyAverages < ActiveRecord::Migration[8.1]
  def change
    create_table :monthly_averages do |t|
      t.date :month
      t.string :subject
      t.float :avg_low
      t.float :avg_high
      t.integer :result_count

      t.timestamps
    end
  end
end
