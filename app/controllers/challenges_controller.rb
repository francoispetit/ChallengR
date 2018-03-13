class ChallengesController < ApplicationController
 def index
    @challenges = Challenge.all
  end

  def new
    @challenge = Challenge.new
  end

  def show
    @challenge = Challenge.find(params[:id])
  end

  def edit
    @challenge = Challenge.find(params[:id])
  end

  def update
    @challenge = Challenge.find(params[:id])
    @challenge.update(challenge_params)
    redirect_to @challenge
  end

  def create
    @challenge = Challenge.create(challenge_params)
    redirect_to @challenge
  end

  def destroy
    @challenge = Challenge.find(params[:id])

    if current_user.id == @challenge.current_user_id
     @challenge.destroy
     redirect_to root_path
    else
      flash[:danger] = "Désolé, ce challenge n'est pas le votre !"
    end

  end

  private
  def challenge_params
  params.require(:challenge).permit(:goal, :deadline)
  end
end
