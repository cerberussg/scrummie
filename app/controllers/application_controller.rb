class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  layout :layout_by_resource

  helper_method :current_account
  helper_method :current_date

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :error => exception.message
  end
  add_flash_types :error

  def current_account
    @current_account ||= current_user.account
    @current_account
  end

  def current_date
    session[:current_date] = session[:current_date] || Date.today.strftime('%a %d %b %Y')
    @current_date ||= session[:current_date]
  end

  protected
  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
end
