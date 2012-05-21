class Admin::JudgeMembershipsController < Admin::AdminController
  inherit_resources
  belongs_to :competition
  actions :show, :new, :create, :destroy
  load_and_authorize_resource

  def create
    create! { [:admin, @competition] }
  end
end
