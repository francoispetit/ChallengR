class AddOrganizerToChallenges < ActiveRecord::Migration[5.1]
  def change
  	add_reference :challenges, :organizer, foreign_key: true
  end
end
