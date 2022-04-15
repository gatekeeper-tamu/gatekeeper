class Users::RegistrationsController < Devise::RegistrationsController
	prepend_view_path "app/views/devise"
	def after_update_path_for(resource)
		user_root_path(resource.username)
	end

	def create
		super
		if @user.persisted?
			NewAccountMailer.new_account_email(@user).deliver
		end
	end
end