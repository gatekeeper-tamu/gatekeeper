class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user, only: %i[ show ]
	def show 
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      begin
		if (current_user.username == params[:username])
      #if user is current user, display the profile page including options to edit profile
			@user = current_user
		else
			@user = User.find_by_username(params[:username])
      #if user exists, the profile page is displayed
        end
      rescue ActiveRecord::RecordNotFound => e
        puts "Can't access this page!"
        #if user does not exist, display error 404 page
        redirect_to "/404.html"
      rescue => exception
        puts "ERROR! -> #{exception}"
      end
      
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:search, :username)
    end
end
