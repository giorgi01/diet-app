class AddDailyCaloriesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :daily_calories, :integer, default: 2200
  end
end
