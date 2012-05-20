class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  def set_locale
    I18n.locale = extract_locale_from_subdomain || I18n.default_locale
  end

  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    unless parsed_locale.blank?
      I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : nil
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Nie masz prawa do wykonania tej akcji!"
    redirect_to root_url
  end

end
