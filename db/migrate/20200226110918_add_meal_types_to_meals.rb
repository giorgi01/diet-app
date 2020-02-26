class AddMealTypesToMeals < ActiveRecord::Migration[5.2]
  def change
    remove_column :meals, :time
    add_column :meals, :meal_type, :string
  end
end
