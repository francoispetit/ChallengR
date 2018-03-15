class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@challenges = []
		@challenges = @user.attended_challenges
	end


end
