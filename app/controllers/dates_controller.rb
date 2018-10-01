class DatesController < ApplicationController
  def update
    session[:current_date] = params[:date]
    redirect_back(fallback_location: root_path, turbolinks: true)
  end
end