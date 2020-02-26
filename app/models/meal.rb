class Meal < ApplicationRecord
  belongs_to :user
  validates_presence_of :date, :meal_type, :name, :calories
  validates :calories, numericality: { greater_than_or_equal_to: 0 }
  scope :having_date_between, ->(start_date, end_date) {
    where("date BETWEEN '#{start_date.values.first}' AND '#{end_date.values.first}'")
  }

  def self.todays_meals
    where(date: Date.today)
  end

  def self.meal_types
    %w(Breakfast Lunch Dinner)
  end
end
