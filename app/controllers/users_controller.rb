class UsersController < ApplicationController

  before_action :require_manager, only: [:manager_panel]
  before_action :require_admin, only: [:admin_panel, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update]

  def manager_panel

  end

  def admin_panel

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

  def limit_edit
    @user = current_user
  end

  def limit_update
    @user = current_user
    if @user.update(limit_params)
      flash[:success] = 'Daily limit was successfully updated'
      redirect_to meals_path
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