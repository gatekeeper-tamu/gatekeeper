class Users::RegistrationsController < Devise::RegistrationsController
	prepend_view_path "app/views/devise"
	def after_update_path_for(resource)
		user_root_path(resource.username)
	end
end