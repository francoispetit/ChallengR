class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@challenges = @user.attended_challenges
		@firstchallengestats = @challenges.first.participations.find_by_user_id(@user.id)

		#eval(@challenges.first.participations.find_by_user_id(@user.id).stats)[:subgoal1][:date_accomplised]
	end

	def dashboard
		@user = User.find(params[:id])
		@challenges = @user.attended_challenges
	end

end
