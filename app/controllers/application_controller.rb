class ApplicationController < ActionController::Base
	# protect_from_forgery
	# http_basic_authenticate_with name: 'admin', password: 'admin', except: [:index, :show]
  include SessionsHelper
  
  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
