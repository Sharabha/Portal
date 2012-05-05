class Admin::ProblemsController < Admin::AdminController
  inherit_resources
  actions :all
  load_and_authorize_resource
  before_filter :set_author_id, :only => [:create]

  private
    def set_author_id
      resource.author_id = current_user.id
    end
end
