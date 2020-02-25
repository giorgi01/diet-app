class UsersController < ApplicationController
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

  def limit_params
    params.require(:user).permit(:daily_calories)
  end
end