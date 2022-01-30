class UsersController < ApplicationController
	def show 
		@user = current_user
		# puts @user[:id]
		#puts @user.username
	end
end
