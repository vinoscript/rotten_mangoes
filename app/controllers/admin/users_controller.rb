class Admin::UsersController < ApplicationController

  before_filter :restrict_access

  def restrict_access
    if !current_user.admin
      flash[:alert] = "Restricted Access - Admin Users Only"
      redirect_to movies_path
    end
  end

  def index
    @users = User.all.page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

end

