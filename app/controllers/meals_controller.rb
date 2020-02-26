class MealsController < ApplicationController

  before_action :set_meal, only: [:show, :destroy, :edit, :update]

  def index
    @user_meals = current_user.meals.todays_meals
  end

  def new
    @meal = current_user.meals.new
  end

  def create
    @meal = current_user.meals.new(meal_params)
    if @meal.save
      flash[:success] = 'Meal was successfully added'
      redirect_to meals_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @meal.update(meal_params)
      flash[:success] = 'Meal was successfully updated'
      redirect_to meals_path
    else
      render 'edit'
    end
  end

  def show

  end

  def destroy
    @meal.destroy
    flash[:success] = 'Meal was successfully removed'
    redirect_to meals_path
  end

  def meals_history
    @user_meals = current_user.meals
  end

  private

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:date, :meal_type, :name, :calories, :user_id)
  end
end
