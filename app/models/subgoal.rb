class Subgoal < ApplicationRecord
   belongs_to :challenge

<<<<<<< HEAD
   validates :subgoal_string, :duedate, :description, :accomplished, presence: true
=======
   validates :subgoal_string, :deadline, :description, :accomplished, presence: true
>>>>>>> viewindex

end
