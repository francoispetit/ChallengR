class Subgoal < ApplicationRecord
   belongs_to :challenge
   validates :subgoal_string, :deadline, :description, :accomplished, presence: true

end
