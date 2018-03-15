class Challenge < ApplicationRecord
  has_many :subgoals, dependent: :destroy

  belongs_to :organizer, class_name: "User"
  has_many :participations, dependent: :destroy
  has_many :attendees, class_name:"User", through: :participations, source: :user
  accepts_nested_attributes_for :subgoals,
    :allow_destroy => true,
    :reject_if => :all_blank
  has_and_belongs_to_many :categories
  has_many :comments, as: :commentable , dependent: :destroy
  validates :goal, presence: true
end
