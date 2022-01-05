class UsersController < ApplicationController
	def show 
		puts current_user.email
		render plain: "Success"
		# @user = User.find(params[:id])
	end
end
