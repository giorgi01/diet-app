class Meal < ApplicationRecord
  belongs_to :user
  validates_presence_of :date, :time, :name, :calories
  validates :calories, numericality: { greater_than_or_equal_to: 0 }

  def self.todays_meals
    where(date: Date.today)
  end
end
