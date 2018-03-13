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
    @challenge = Challenge.new(challenge_params)
    @challenge.organizer = current_user
     if @challenge.save
      flash[:success] = "Challenge créé."
    redirect_to @challenge
      else render 'new'
      end
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

  def join_challenge
    @challenge = Challenge.find(params[:id])
    if @challenge.attendees.include? current_user
        flash[:error] = "Héhé, vous y participez déjà"
        redirect_to @challenge
    else 
      @challenge.attendees << current_user
      flash[:success] = "Bienvenue dans l'équipe !"
      redirect_to @challenge
    end
  end 


  private
  def challenge_params
  params.require(:challenge).permit(:goal, :deadline)
  end
end


