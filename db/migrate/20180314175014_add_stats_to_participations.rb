class AddStatsToParticipations < ActiveRecord::Migration[5.1]
  def change
    add_column :participations, :stats, :text
  end
end
