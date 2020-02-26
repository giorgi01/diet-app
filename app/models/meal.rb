class Meal < ApplicationRecord
  belongs_to :user
  validates_presence_of :date, :meal_type, :name, :calories
  validates :calories, numericality: { greater_than_or_equal_to: 0 }

  def self.todays_meals
    where(date: Date.today)
  end

  def self.meal_types
    %w(Breakfast Lunch Dinner)
  end

end
