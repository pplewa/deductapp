class ApplicationController < ActionController::Base
  protect_from_forgery

  def set_time_zone
	  Time.zone = current_user.time_zone unless current_user.blank?
	end
end
