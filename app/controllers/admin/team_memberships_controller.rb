class Admin::TeamMembershipsController < Admin::AdminController
  inherit_resources
  belongs_to :competition
  actions :show, :new, :create, :destroy
  load_and_authorize_resource

  def create
    create! { @competition }
  end
end
