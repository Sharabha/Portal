class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|  
    flash[:error] = "Nie masz prawa do wykonania tej akcji!"  
    redirect_to root_url  
  end  
end
