class SubgoalsController < ApplicationController
    def index
   @subgoals =Subgoal.all
  end

  def new
      @challenge = Challenge.find(:id)
      @subgoal = @challenge.subgoals.build
  end

  def show
   @subgoal = Subgoal.find(params[:id])
  end

  def edit
   @subgoal = Subgoal.find(params[:id])
  end

  def update
   @subgoal = Subgoal.find(params[:id])
   @subgoal.update(subgoal_params)
    redirect_to @subgoal
  end

  def create
    @challenge = Challenge.find(:id)
      @subgoal = @challenge.subgoals.create(params[:subgoal])
  end

  def destroy
   @subgoal = Subgoal.find(params[:id])

    if current_user.id == @subgoal.current_user_id
    @subgoal.destroy
     redirect_to root_path
    else
      flash[:danger] = "Désolé, ce n'est pas votre objectif !"
    end

  end

  def subgoal_done
      @subgoal = Subgoal.find(params[:id])
      if @subgoal.accomplished? true
      flash[:success] = "votre objectif est rempli"
      end
  end

  private
  def subgoal_params
  params.require(:subgoal).permit(:subgoal_int, :subgoal_unit, :subgoal_string, :deadline, :description, :accomplished, :challenge_id)
  end



 
 
end
