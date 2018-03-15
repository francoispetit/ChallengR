class Subgoal < ApplicationRecord

   belongs_to :challenge

   validates :subgoal_string, :deadline, presence: true

end
