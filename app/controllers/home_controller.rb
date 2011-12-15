class HomeController < ApplicationController

  before_filter :authenticate_user!

  def index
    @invitations = Invitation.find_by_user_id(current_user.id)
  end
end
