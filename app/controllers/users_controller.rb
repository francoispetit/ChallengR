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
                if flash[:unitgraph] != nil
                  gon.unitgraph = true
                  @unit = Unit.find(flash[:unitgraph]["id"])
		  @challenge = Challenge.find(session[:chall]["id"])
                  gon.data = @stats = current_user.participations.find_by_challenge_id(@challenge.id).stats
                  session[:unitgraph] = nil
                end
	end

  def unitboard
          @challenge = Challenge.find(params[:challid])
    	@unit = Unit.find(params[:id])
          flash[:unitgraph] = @unit
          session[:chall] = @challenge
          redirect_to dashboard_path
  end

	def profile
		@user = User.find(params[:id])
	end

	def setbest
		@challenge = Challenge.find(params[:challid])

    @keyswithsubid = []
    params.keys.each do |key|
  		@keyswithsubid << key unless ["utf8","authenticity_token","challid","commit","controller","action","id"].include?(key)

		end
		@subgoal = @challenge.subgoals.find(@keyswithsubid.first.gsub(/[^0-9]/, ""))

	#	@subgoal_index = get_subgoal_index(@subgoal)
    a = current_user.participations.find_by_challenge_id(@challenge.id)

    a.stats[:subgoals_bests].each do |hashh|

		  if hashh[:name] == @subgoal.subgoal_string

		    hashh[:best].each do |k, v|
		      v[0] = params[eval("'#{k}#{@subgoal.id}'")]

		    end
			end
		end

    a.save
		render "users/dashboard"
	end

private

	def check_user
		b=0
		current_user.participations.each do |p|
			unless p.stats[:subgoals_bests] == nil
				b+=1
			end
		end
		if current_user.attended_challenges == [] || current_user == nil || b == 0
			  redirect_to root_path
			  flash[:notice] = "You must avoir un challenge"
		end
		@user = current_user
		@challenges = @user.attended_challenges
		@participations = @user.participations
	end

	def get_challenge
			if params[:challid]==nil
				@challenge = current_user.attended_challenges.first
			else
				@challenge = Challenge.find(params[:challid])
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

	def get_subgoal_index(subg)
		@challenge.subgoals.each do |sub, index|

			if sub.subgoal_string == subg.subgoal_string
				return index
			end
		end

	end


end
