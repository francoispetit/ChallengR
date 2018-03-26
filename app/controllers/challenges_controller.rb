class ChallengesController < ApplicationController

  skip_before_action :verify_authenticity_token, :only => [:preupdate_units, :update_units]

  def index
    red_id = User.find_by_username("The Red User").id
    @challenges = Challenge.where.not(organizer_id:red_id).order(created_at: :desc).page(params[:page])
  end

  def red_index
    red_id = User.find_by_username("The Red User").id
    @challenges = Challenge.where(organizer_id:red_id)
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
     if @challenge.organizer != current_user
       redirect_to challenge_path(params[:id])
     end
  end

  def edit_units
    @challenge = Challenge.find(params[:id])
    if @challenge.organizer != current_user
      redirect_to challenge_path(params[:id])
    end
  end

  def add_unit
    @challenge = Challenge.find(params[:id])
    unit = @challenge.units.build(unit_params)
    unit.save
    redirect_to edit_units_path
  end

  def remove_unit
    @challenge = Challenge.find(params[:id])
    @challenge.units.find(params[:unitid]).destroy
    redirect_to edit_units_path
  end

  def preupdate_units
    @challenge = Challenge.find(params[:id])
  end

  def update_units
    @challenge = Challenge.find(params[:id])
    @challenge.subgoals.each do |sub|
      sub.targets.destroy_all
    end
    @targets = {}
    @challenge.subgoals.each do |sub|
      @targets["#{sub.subgoal_string}"] = {}
      @challenge.units.each do |unit|
        @targets["#{sub.subgoal_string}"]["#{unit.unit_name}"] = eval("params['#{unit.unit_name}#{sub.id}']")
        @tar = sub.targets.build(unit_id:unit.id, subgoal_id:sub.id, value:eval("params['#{unit.unit_name}#{sub.id}'].to_i"))
        @tar.save
      end
    end
    @challenge.attendees.each do |attendee|
      @participation = attendee.participations.find_by_challenge_id(@challenge.id)
      @participation.stats = {units:[], subgoals_bests:[]}
@challenge.units.each do |unit|
@participation.stats[:units] << unit.unit_name
end
      @challenge.subgoals.length.times do |x|
        @participation.stats[:subgoals_bests][x] = {}
        @participation.stats[:subgoals_bests][x][:name] = @challenge.subgoals[x].subgoal_string
        @participation.stats[:subgoals_bests][x][:best] = {}
          @challenge.units.each do |unit|
            @participation.stats[:subgoals_bests][x][:best][unit.unit_name.to_sym] = [0,params[eval("'#{unit.unit_name}#{@challenge.subgoals[x].id}'")]]
        end
      end
      @participation.save
    end

    redirect_to challenge_path(@challenge.id)

  end


  def addtargetstosubgoals
    @subgoals = @challenge.subgoals
  end

  def update

    @challenge = Challenge.find(params[:id])
    sp = subgoal_params["subgoals_attributes"]
    @challenge.subgoals = []
    nsub_save = 0
    if @challenge.update(challenge_params)
      sp.keys.length.times do |n|
        unless eval("sp['#{n}']['_destroy'] == '1'")
          eval("@subgoal#{n} = @challenge.subgoals.build(sp['#{n}'])")
          nsub_save += 1 if eval("@subgoal#{n}.save")
        else
          nsub_save += 1
        end
      end
    end
    if nsub_save == sp.keys.length
      redirect_to @challenge
    else
      render 'edit'
    end
  end

  def create
    @challenge = Challenge.new(challenge_params)
    sp = subgoal_params["subgoals_attributes"]

    @challenge.organizer = current_user
    if @challenge.save
      if sp == nil
        sp = {}
      end
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
          render 'show'
        else
          flash[:danger] = "Challenge créé, mais création de subgoals échouée!"
          render 'show'
        end

    else
      render 'new'
    end
  end

  def clone_challenge
    @challenge = Challenge.find(params[:id])
    @clonedchall = current_user.organized_challenges.build(@challenge.attributes.merge(id:nil, organizer_id:current_user.id, created_at:nil, updated_at:nil))
    @clonedchall.save
    @clonedchall.attendees << current_user
    @challenge.subgoals.each do |sub|
      @sub = @clonedchall.subgoals.build(sub.attributes.merge(id:nil, challenge_id:@clonedchall.id, created_at:nil, updated_at:nil))
      @sub.save
    end
    redirect_to challenge_path(@clonedchall.id)
  end

  def set_category()
    category = Category.find(params[:catid])
    @challenge = Challenge.find(params[:id])
    @challenge.categories << category unless @challenge.categories.include? category
    redirect_to challenge_path(@challenge)
  end

  def remove_category()
    @challenge = Challenge.find(params[:id])
    @challenge.categories.delete(params[:catid]) if @challenge.categories.include? Category.find(params[:catid])
    redirect_to challenge_path(@challenge)
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
   if @challenge.organizer == current_user
     @challenge.destroy
     redirect_to root_path
     flash[:success] = "Votre challenge a été supprimé !"
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
      @participation = current_user.participations.find_by_challenge_id(@challenge.id)
      @participation.stats = {units:[], subgoals_bests:[]}
      @challenge.units.each do |unit|
        @participation.stats[:units] << unit.unit_name

      end
      @challenge.subgoals.length.times do |x|
        @participation.stats[:subgoals_bests][x] = {}
        @participation.stats[:subgoals_bests][x][:name] = @challenge.subgoals[x].subgoal_string
        @participation.stats[:subgoals_bests][x][:best] = {}
          @challenge.units.each do |unit|
            @participation.stats[:subgoals_bests][x][:best][unit.unit_name.to_sym] = [0,@challenge.organizer.participations.find_by_challenge_id(@challenge.id).stats[:subgoals_bests][x][:best][unit.unit_name.to_sym][1]]
        end
      end
      @participation.save
      flash[:success] = "Bienvenue dans l'équipe !"
      redirect_to @challenge
    end
  end

  def unjoin_challenge
    current_user.attended_challenges.delete(params[:id])
    redirect_to Challenge.find(params[:id])
  end

  private

  def challenge_params
    params.require(:challenge).permit(:goal, :deadline, :accomplished, :subgoals_attributes, :image, :id)

  end

 def subgoal_params
  params.require(:challenge).permit(subgoals_attributes: [:_destroy, :subgoal_int, :subgoal_unit, :subgoal_string, :deadline, :description, :accomplished, :challenge_id]) # This permits the kids params to be saved


  #params.require(:challenge).permit(:subgoals_attributes, :subgoal_int, :subgoal_unit, :subgoal_string, :deadline, :description, :accomplished, :challenge_id)
 end

  def unit_params
    params.permit(:unit_name)
  end

end
