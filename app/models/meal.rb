class Meal < ApplicationRecord
  belongs_to :user
  validates_presence_of :date, :time, :name, :calories
end
