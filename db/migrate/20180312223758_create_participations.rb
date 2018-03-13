class CreateParticipations < ActiveRecord::Migration[5.1]
  def change
    create_table :participations do |t|
      t.integer :challenge_id
      t.integer :user_id
      t.boolean :accomplished
      t.timestamps
    end
    add_index :participations, :user_id
    add_index :participations, :challenge_id
  end
end
