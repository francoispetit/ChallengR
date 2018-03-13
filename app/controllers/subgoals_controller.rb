

class SubgoalsController < ApplicationController
 
 def subgoal_done
      @subgoal = Subgoal.find(params[:id])
      if @subgoal.accomplished? true
      flash[:success] = "votre objectif est rempli"
      end
end
