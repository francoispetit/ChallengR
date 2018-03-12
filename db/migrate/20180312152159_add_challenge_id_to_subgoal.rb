class AddChallengeIdToSubgoal < ActiveRecord::Migration[5.1]
  def change
    add_column :subgoals, :challenge_id, :integer
  end
end
