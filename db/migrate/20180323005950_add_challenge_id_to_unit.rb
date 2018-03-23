class AddChallengeIdToUnit < ActiveRecord::Migration[5.1]
  def change
    add_column :units, :challenge_id, :integer
  end
end
