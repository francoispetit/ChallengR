class Challenge < ApplicationRecord
  has_many :subgoals, dependent: :destroy
<<<<<<< HEAD
  has_one :organizer, class_name: "User"
  has_and_belongs_to_many :attendees, class_name: "User"
=======
  belongs_to :organizer, class_name: "User"
  has_many :participations
  has_many :attendees, class_name:"User", through: :participations, source: :user
>>>>>>> viewindex

  validates :goal, presence: true
end
