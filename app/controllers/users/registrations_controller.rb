class Users::RegistrationsController < Devise::RegistrationsController
	prepend_view_path "app/views/devise"
	def new
		super
	end

	def destroy
		super
	end

	def create
		# # username = sign_up_params[:email].split("@").first
		# # puts "Username = #{username}"
		# # sign_up_params[:username] = username
		# # puts sign_up_params
		# # puts "Updated user: email=#{sign_up_params[:email]}, username=#{sign_up_params[:username]}"
		# build_resource(sign_up_params)

		# resource.save
		# yield resource if block_given?
		# if resource.persisted?
		# if resource.active_for_authentication?
		# 	set_flash_message! :notice, :signed_up
		# 	sign_up(resource_name, resource)
		# 	respond_with resource, location: after_sign_up_path_for(resource)
		# else
		# 	set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
		# 	expire_data_after_sign_in!
		# 	respond_with resource, location: after_inactive_sign_up_path_for(resource)
		# end
		# else
		# 	clean_up_passwords resource
		# 	set_minimum_password_length
		# 	respond_with resource
		# end
		super
	end

	def update
		# @user = current_user
		# @user.username = @user.email.split("@").first
		# puts "Updated user: email=#{@user.email}, username=#{@user.username}"
		super
	end

	def edit
		# @user = current_user
		# @user.username = @user.email.split("@").first
		# puts "Updated user: email=#{@user.email}, username=#{@user.username}"
		super
	end
end