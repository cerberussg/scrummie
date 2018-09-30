class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  layout :layout_by_resource

  helper_method :current_account

  def current_account
    @current_account ||= current_user.account
    @current_account
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
