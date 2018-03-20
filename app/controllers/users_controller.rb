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
		@participations = @user.participations

		@participations.find_by_challenge_id(Challenge.find_by_goal("courir un marathon").id).stats.each do |k,v|

		end

	end

	def getchallenge
		@challenge = Challenge.find(params[:id])
	end

end
