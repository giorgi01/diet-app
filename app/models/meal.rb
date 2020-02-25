class Meal < ApplicationRecord
  belongs_to :user
  validates_presence_of :date, :time, :name, :calories

  def self.todays_meals
    where(date: Date.today)
  end
end
