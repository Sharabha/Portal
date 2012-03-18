class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @administrators = Role.where(:name => 'admin').users
    @users = User.all
  end

  def make_admin
    @user = User.find(params[:id])
    authorize! :make_admin, @user
    @user.roles << Role.all
    if @user.save
      redirect_to users_path
    end
  end

  def remove_admin
    @user = User.find(params[:id])
    authorize! :remove_admin, @user
    @user.roles.delete(Role.where(:name => 'admin'))
    if @user.save
      redirect_to users_path
    end
  end
end
