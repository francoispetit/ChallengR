class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :organized_challenges, class_name: "Challenge"
  has_and_belongs_to_many :attended_challenges, class_name: "Challenge"

  validates :username, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
  					length: { maximum: 255},
  					format: { with: VALID_EMAIL_REGEX },
  					uniqueness: {case_sensitive: false}

  validates :password, presence: true, length: { minimum: 6 }

end
