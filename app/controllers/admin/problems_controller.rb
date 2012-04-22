class Admin::ProblemsController < Admin::AdminController
  inherit_resources
  actions :all
  load_and_authorize_resource
end
