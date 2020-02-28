class UsersController < ApplicationController

  before_action :require_manager, only: [:manager_panel]
  before_action :require_admin, only: [:admin_panel, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :limit_edit, :limit_update, :toggle_manager]
  before_action :require_staff, only: [:show]

  def manager_panel
    @meals_all = Meal.paginate(page: params[:page], per_page: 5).all
  end

  def admin_panel
    @meals_all = Meal.paginate(page: params[:page], per_page: 5).all
  end

  def show

  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:success] = 'User was successfully updated'
      redirect_to user_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash.notice = "User '#{@user.email}' was deleted"
    redirect_to admin_path
  end

  def toggle_manager
    if @user.manager?
      @user.user!
    elsif @user.user?
      @user.manager!
    end
    redirect_to admin_path
  end

  def limit_edit

  end

  def limit_update
    if @user.update(limit_params)
      flash[:success] = 'Daily limit was successfully updated'
      case
      when current_user.manager?
        redirect_to manager_path
      when current_user.admin?
        redirect_to admin_path
      else
        redirect_to meals_path
      end
    else
      render 'limit_edit'
    end
  end

  private

  def require_manager
    if !current_user.manager?
      redirect_to root_path
      flash[:notice] = 'You are not a manager'
    end
  end

  def require_admin
    if !current_user.admin?
      redirect_to root_path
      flash[:notice] = 'You are not an admin'
    end
  end

  def require_staff
    if !current_user.admin? and !current_user.manager?
      redirect_to root_path
      flash[:notice] = 'You are cannot do that action'
    end
  end

  def limit_params
    params.require(:user).permit(:daily_calories)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :daily_calories)
  end
end