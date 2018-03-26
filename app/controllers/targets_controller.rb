class TargetsController < ApplicationController

  before_action :set_target, only:[:edit, :create, :update, :destroy]

  def new
    @subgoal = Subgoal.find(:id)
    @target = @subgoal.targets.build
  end

  def create
    @subgoal = Subgoal.find(:id)
    @target = @subgoal.targets.create(params[:target])
  end

  def edit
  end

  def update
    @target.update(target_params)
  end

  def destroy
    if @challenge.organizer_id == current_user.id
    @target.destroy
    end
  end

  private

  def target_params
    params.require(:target).permit(:subgoal_int, :unit, :value)
  end

  def set_target
    @target = Target.find(params[:id])
  end

end
