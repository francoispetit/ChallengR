class Unit < ApplicationRecord
belongs_to :challenge
has_many :targets
end
