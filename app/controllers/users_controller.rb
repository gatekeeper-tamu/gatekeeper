class UsersController < ApplicationController
	def show 
		@user = current_user
		puts @user.email
		puts @user.username
	end
end
