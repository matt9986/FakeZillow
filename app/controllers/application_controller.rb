class ApplicationController < ActionController::Base
  protect_from_forgery

	def check_login
		unless logged_in?
      respond_to do |format|
        format.html { redirect_to new_session_url }
        format.json { render json: "Please log in", status: 401 }
      end
		end
	end

  include SessionsHelper
end