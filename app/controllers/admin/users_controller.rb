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
    UserMailer.delete_email(@user).deliver_now
    flash[:notice] = "User #{@user.email} was deleted."
    @user.destroy
    redirect_to admin_users_path
  end

  def create

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def make_admin
    @user = User.find(params[:user_id])
    
    if @user.update_attribute :admin, true
      flash[:notice] = "User #{@user.full_name} is admin."
      redirect_to admin_users_path
    else
      flash[:notice] = "Unable to process change."
      redirect_to admin_users_path
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :admin)
  end

end

