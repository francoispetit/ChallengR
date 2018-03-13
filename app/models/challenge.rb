class Challenge < ApplicationRecord
  has_many :subgoals, dependent: :destroy
  belongs_to :organizer, class_name: "User", foreign_key: "user_id"
  has_many :attendees, class_name: "User", through: :participations
  has_many :participations

  validates :goal, presence: true
end
