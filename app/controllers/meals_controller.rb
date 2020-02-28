class MealsController < ApplicationController

  before_action :set_meal, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @user_meals = current_user.meals.todays_meals.paginate(page: params[:page], per_page: 5)
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
      case
      when current_user.manager?
        redirect_to manager_path
      when current_user.admin?
        redirect_to admin_path
      else
        redirect_to meals_path
      end
    else
      render 'edit'
    end
  end

  def show

  end

  def destroy
    @meal.destroy
    flash[:success] = 'Meal was successfully removed'
    case
    when current_user.manager?
      redirect_to manager_path
    when current_user.admin?
      redirect_to admin_path
    else
      redirect_to meals_path
    end
  end

  def meals_history
    @user_meals = current_user.meals.paginate(page: params[:page], per_page: 5)
    @meals_all = Meal.all.order(:date).paginate(page: params[:page], per_page: 5)
  end

  def filter_new
    @filtered_meals = current_user.meals.order(:date).paginate(page: params[:page], per_page: 5)
  end

  def filter
    @filtered_meals = current_user.meals.
        having_date_between(params.require(:filter).permit(:start_date),
                            params.require(:filter).permit(:end_date))
                          .order(:date)
                          .paginate(page: params[:page], per_page: 5)
    render 'filter'
  end

  private

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:date, :meal_type, :name, :calories, :user_id)
  end

  def require_same_user
    if current_user != @meal.user and !current_user.admin? and !current_user.manager?
      flash[:notice] = "You can only edit your meals"
      redirect_to root_path
    end
  end
end
