class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username])
	end

	public
	def login
		authenticate_user!
	end

	def after_sign_in_path_for(resource)
		stored_location_for(resource) || if resource.is_a?(User) && resource.username
			subscription_root_path # (resource.username)
		else
			puts "couldn't find path for #{resource}"
			root_path
		end
	end
end
