class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @administrators = User.where(:admin => true)
    @users = User.where(:admin => false)    
  end

  def make_admin
    @user = User.find(params[:id])
    authorize! :make_admin, @user
    @user.admin = true
    if @user.save
      redirect_to users_path
    end
  end

  def remove_admin
    @user = User.find(params[:id])
    authorize! :remove_admin, @user
    @user.admin = false
    if @user.save
      redirect_to users_path
    end
  end
end
