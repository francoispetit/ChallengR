class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role(r=:user)
    self.role = r
  end


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :messages
  has_many :subscriptions
  has_many :chats, through: :subscriptions
  
  has_many :organized_challenges, class_name: "Challenge", foreign_key: "organizer_id"
  has_many :participations
  has_many :attended_challenges, class_name: "Challenge", through: :participations, source: :challenge
  has_many :comments


  validates :username, presence: true
  validates :username, uniqueness: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
  					length: { maximum: 255},
  					format: { with: VALID_EMAIL_REGEX },
  					uniqueness: {case_sensitive: false}

  validates :password, presence: true, length: { minimum: 6 }


  def existing_chats_users
    existing_chat_users = []
    self.chats.each do |chat|
    existing_chat_users.concat(chat.subscriptions.where.not(user_id: self.id).map {|subscription| subscription.user})
    end
    
    existing_chat_users.uniq
  end

end
