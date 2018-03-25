class UsersController < ApplicationController

	before_action :check_user, on: [:dashboard, :sestbest]
	before_action :get_challenge, on: [:dashboard, :sestbest]
	before_action :get_subgoal, on: [:dashboard, :sestbest]

	def show
		@user = User.find(params[:id])
		@challenges = @user.attended_challenges
		@firstchallengestats = @challenges.first.participations.find_by_user_id(@user.id)
	end

	def dashboard
		gon.data = @stats
	end

	def profile
		@user = User.find(params[:id])
	end

	def setbest
		@challenge = Challenge.find(params[:id])
		@subgoal_index = get_subgoal_index
	end

private

	def check_user
		if current_user.attended_challenges == [] || current_user == nil || current_user.participations.first.stats[:subgoals_bests] == nil
			redirect_to root_path
			flash[:notice] = "You must avoir un challenge"
		end
		@user = current_user
		@challenges = @user.attended_challenges
		@participations = @user.participations
	end

	def get_challenge
			if params[:chal_id]==nil
				@challenge = current_user.attended_challenges.first
			else
				@challenge = Challenge.find(params[:chal_id])
			end
			@stats = @participations.find_by_challenge_id(@challenge.id).stats
	end

	def get_subgoal
		if params[:subgoal_name] == nil
			@subgoal = @challenge.subgoals.first
			@subgoal_index = 0
		else
			@subgoal = Subgoal.find_by_subgoal_string(params[:subgoal_name])
		end
	end

	def get_subgoal_index
		@challenge.subgoals.each do |sub, index|

			if sub.subgoal_string == @subgoal.subgoal_string
				return index
			end
		end

	end


end
