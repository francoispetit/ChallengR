class CreateParticipations < ActiveRecord::Migration[5.1]
  def change
    create_table :participations do |t|
      t.boolean :accomplished
      t.integer :user_id
      t.integer :challenge_id
      t.timestamps
    end
  end
end
