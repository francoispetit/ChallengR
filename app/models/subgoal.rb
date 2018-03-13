class Subgoal < ApplicationRecord
   belongs_to :challenge
<<<<<<< HEAD

<<<<<<< HEAD
   validates :subgoal_string, :duedate, :description, :accomplished, presence: true
=======
   validates :subgoal_string, :deadline, :description, :accomplished, presence: true
>>>>>>> viewindex
=======
   validates :subgoal_string, :deadline, :description, :accomplished, presence: true
>>>>>>> d26febe3bd1c53b0d030f74f029d0039e7d3707c

end
