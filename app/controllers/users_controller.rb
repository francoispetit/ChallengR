class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@challenges = @user.attended_challenges
		@firstchallengestats = @challenges.first.participations.find_by_user_id(@user.id)

		#eval(@challenges.first.participations.find_by_user_id(@user.id).stats)[:subgoal1][:date_accomplised]
	end

	def dashboard
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
		@label = []
		@data = {
			targets:["km", "mn"],
			subgoals_bests:[
				{
					name:"10 km en 1h",
					best:{
						km:[11, 10],
						mn:[58, 60]
					}
				},
				{
					name:"10 km en 50mn",
					best:{
						km:[10,10],
						mn:[49,50]
					}
				},
				{
					name:"20 km en 2h",
					best:{
						km:[21,20],
						mn:[119,120]
					}
				}]
			}

		gon.data = @data

			if params[:subgoal_name] == nil
				@subgoal = @challenge.subgoals.first
			else
				@subgoal = Subgoal.find_by_subgoal_string(params[:subgoal_name])
				@stats[:subgoals].each_value do |sub|
					if sub[:subgoal_string] == @subgoal.subgoal_string
						sub[:subgoal_attempts].each_value do |attempt|
							@data << attempt[:attempt_results][:t1]
							@label << attempt[:date_attempt]
						end
					end
				end
			end
	end

	def getchallenge
		@challenge = Challenge.find(params[:id])
	end

end
