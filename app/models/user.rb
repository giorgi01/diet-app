class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :meals, dependent: :delete_all
  enum role: { user: 0, manager: 1, admin: 2 }

  def calories_taken
    sum = 0
    Meal.todays_meals.each { |m| sum += m.calories if m.user_id == self.id }
    sum
  end

  def calories_left
    self.daily_calories - calories_taken
  end
end
