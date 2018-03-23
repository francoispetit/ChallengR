class UsersController < ApplicationController

	before_action :check_user, on: [:dashboard, :gestbest]
	before_action :get_subgoal, on: [:dashboard, :gestbest]

	def show
		@user = User.find(params[:id])
		@challenges = @user.attended_challenges
		@firstchallengestats = @challenges.first.participations.find_by_user_id(@user.id)
	end

	def dashboard

		gon.data = @stats

	end

	def setbest
		@challenge = Challenge.find(params[:id])
	end

	private

	def check_user
		if current_user.attended_challenges == [] || current_user == nil
			redirect_to root_path
			flash[:notice] = "You must avoir un challenge"
		end
		@user = current_user
		@challenges = @user.attended_challenges
		@participations = @user.participations

		if params[:chal_id] == nil
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
			def getsindex
				@challenge.subgoals.each do |sub, index|
				if sub.subgoal_string == @subgoal.subgoal_string
					return index
				end
			end
			@subgoal_index = 2
			end
		end
	end

end
