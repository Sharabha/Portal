class Admin::GuardianMembershipsController < Admin::AdminController
  inherit_resources
  nested_belongs_to :competition, :problem_membership
  actions :new, :create, :destroy
  load_and_authorize_resource

  def create
    create! { [:admin, @competition] }
  end
end
