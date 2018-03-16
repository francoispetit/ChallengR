 class ChallengesController < ApplicationController
  def index
    @challenges = Challenge.all
  end

  def new
    @challenge = Challenge.new
    @subgoal = Subgoal.new
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
    sp = subgoal_params["subgoals_attributes"]
    
    @challenge.organizer = current_user
    if @challenge.save
      nsub_save = 0
      sp.keys.length.times do |n|
        eval("@subgoal#{n} = @challenge.subgoals.build(sp['#{n}'])")
        nsub_save += 1 if eval("@subgoal#{n}.save")
      end
      @challenge.image_url = "tomatoe800.jpg"
      if nsub_save == sp.keys.length
        copy_challenge_to_vip(@challenge)
        @challenge.attendees << @challenge.organizer
        flash[:success] = "challenge créé"
        redirect_to @challenge
      else
        flash[:danger] = "Challenge créé, mais création de subgoals échouée!"
        render 'show'
      end
    else
      render 'new'
      


    end
  end

  def copy_challenge_to_vip(chall)
      copychall = Challenge.new(chall.attributes.merge(id:nil, organizer_id:User.find_by_username("The Red User").id, attendees:[]))
      copychall.save
      chall.subgoals.length.times do |n|
        copysub = Subgoal.new(chall.subgoals[n].attributes.merge(id:nil, challenge_id:copychall.id))
        copysub.save
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
    params.require(:challenge).permit(:goal, :deadline, :accomplished, :subgoals_attributes)
      #subgoal: [:subgoal_int, :subgoal_unit, :subgoal_string, :duedate, :description, :accomplished, :challenge_id])
    #params.require(:challenge).permit([:goal, :deadline, :accomplished, :subgoal],[:subgoal_int, :subgoal_unit, :subgoal_string, :duedate, :description, :accomplished, :challenge_id])
    #params.require([:challenge, :subgoal]).permit([:goal, :deadline, :accomplished],[:subgoal_int, :subgoal_unit, :subgoal_string, :deadline, :description, :accomplished, :challenge_id])
    #params.require(:challenge).permit(
    #:goal, :deadline, :accomplished, :subgoal,
   # subgoals_attributes: [:subgoal_int, :subgoal_unit, :subgoal_string, :duedate, :description, :accomplished, :challenge_id]) 
  end
  
 def subgoal_params
  params.require(:challenge).permit(subgoals_attributes: [:subgoal_int, :subgoal_unit, :subgoal_string, :deadline, :description, :accomplished, :challenge_id]) # This permits the kids params to be saved


  #params.require(:challenge).permit(:subgoals_attributes, :subgoal_int, :subgoal_unit, :subgoal_string, :deadline, :description, :accomplished, :challenge_id)
 end

end
