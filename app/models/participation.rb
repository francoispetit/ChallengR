class Participation < ApplicationRecord
	belongs_to :challenge
	belongs_to :user
	serialize :stats, Hash
end
