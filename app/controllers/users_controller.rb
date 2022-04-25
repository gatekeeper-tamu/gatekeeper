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
          @user = current_user
        else
          @user = User.find(params[:username])
        end
        rescue ActiveRecord::RecordNotFound => e
          puts "Can't access this page!"
          redirect_to "/404.html"
        end
    end 

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:search, :username)
    end
end
