class Subgoal < ApplicationRecord
   belongs_to :challenge

   #validates :subgoal_string, :duedate, :description, :accomplished, presence:  true


end
