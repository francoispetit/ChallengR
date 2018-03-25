class Subgoal < ApplicationRecord

   belongs_to :challenge
   has_many :targets
   accepts_nested_attributes_for :targets, allow_destroy: true
   validates :subgoal_string, :deadline, presence: true

end
