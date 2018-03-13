class CreateSubgoals < ActiveRecord::Migration[5.1]
  def change
    create_table :subgoals do |t|
      t.integer :subgoal_int
      t.string :subgoal_unit
      t.string :subgoal_string
      t.datetime :deadline
      t.text :description
      t.boolean :accomplished
      t.integer :challenge_id
      t.timestamps
    end
    add_index :subgoals, :challenge_id
    add_foreign_key :subgoals, :challenges
  end
end
