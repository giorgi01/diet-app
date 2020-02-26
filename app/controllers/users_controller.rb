class UsersController < ApplicationController

  before_action :require_manager, only: [:manager_panel]
  before_action :require_admin, only: [:admin_panel]

  def manager_panel

  end

  def admin_panel

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
    redirect_to root_path unless current_user.manager?
    flash[:notice] = 'You are not a manager' unless current_user.manager?
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
    flash[:notice] = 'You are not an admin' unless current_user.admin?
  end

  def limit_params
    params.require(:user).permit(:daily_calories)
  end
end