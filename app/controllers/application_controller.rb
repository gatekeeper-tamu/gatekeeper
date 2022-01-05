class ApplicationController < ActionController::Base
	def login
		authenticate_user!
	end

	def after_sign_in_path_for(user)
		user_profile_path(user)
	end
end
