class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :set_theme

  def set_locale
    cookies[:locale] = params[:locale] || cookies[:locale] || :en
    I18n.locale = cookies[:locale]
  end

  def set_theme
    cookies[:theme] ||= "flatly"
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end

end
