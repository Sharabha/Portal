class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @administrators = Role.where(:name => 'admin').first.users
    @users = User.all
  end
end
