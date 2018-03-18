class Challenge < ApplicationRecord
  has_many :subgoals, dependent: :destroy

  belongs_to :organizer, class_name: "User"
  has_many :participations, dependent: :destroy
  has_many :attendees, class_name:"User", through: :participations, source: :user
  has_attached_file :image  ,styles: { medium: "300x300>", thumb: "100x100>" }
  accepts_nested_attributes_for :subgoals,
    :allow_destroy => true,
    :reject_if => :all_blank
  has_and_belongs_to_many :categories
  has_many :comments, as: :commentable , dependent: :destroy
  validates :goal, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
