class ApplicationController < ActionController::Base
	def login
		authenticate_user!
	end

	def after_sign_in_path_for(resource)
		stored_location_for(resource) || if resource.is_a?(User) && resource.username
			user_root_path(resource.username)
		else
			root_path
		end
	end
end
