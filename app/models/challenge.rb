class Challenge < ApplicationRecord
  has_many :subgoals, dependent: :destroy
  has_one :organizer, class_name: "User", foreign_key: true
  has_and_belongs_to_many :attendees, class_name: "User"

  validates :goal, presence: true
end
