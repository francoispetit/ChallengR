class Challenge < ApplicationRecord
  has_many :subgoals, dependent: :destroy
  belongs_to :organizer, class_name: "User"
  has_many :participations
  has_many :attendees, class_name:"User", through: :participations, source: :user


  validates :goal, presence: true
end
