class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :organized_challenges, class_name: "Challenge", foreign_key: "organizer_id"
<<<<<<< HEAD
<<<<<<< HEAD
  has_and_belongs_to_many :attended_challenges, class_name: "Challenge"
=======
  has_many :participations
  has_many :attended_challenges, class_name: "Challenge", through: :participations, source: :challenge

>>>>>>> viewindex

=======
  has_many :participations
  has_many :attended_challenges, class_name: "Challenge", through: :participations, source: :challenge

>>>>>>> d26febe3bd1c53b0d030f74f029d0039e7d3707c
  validates :username, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
  					length: { maximum: 255},
  					format: { with: VALID_EMAIL_REGEX },
  					uniqueness: {case_sensitive: false}

  validates :password, presence: true, length: { minimum: 6 }

end
