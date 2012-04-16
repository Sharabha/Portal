class Admin::ProblemMembershipsController < Admin::AdminController
  inherit_resources
  belongs_to :competition
  actions :show, :new, :create, :edit, :update, :destroy
  load_and_authorize_resource

  def create
    create! { [:admin, @competition] }
  end

  def update
    update! { [:admin, @competition] }
  end
end
