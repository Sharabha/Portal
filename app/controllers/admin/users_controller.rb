class Admin::UsersController < Admin::AdminController
  inherit_resources
  actions :edit, :update, :index, :destroy
  load_and_authorize_resource

  def update
    resource.roles = Role.where(:id => params[:user][:role_ids])
    update!
  end

  def make_admin
    @user = User.find(params[:id])
    authorize! :make_admin, @user
    @user.roles << Role.find_by_name('admin')
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
