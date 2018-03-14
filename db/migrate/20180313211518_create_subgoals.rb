class CreateSubgoals < ActiveRecord::Migration[5.1]
  def change
    create_table :subgoals do |t|
      t.integer :subgoal_int
      t.string :subgoal_unit
      t.string :subgoal_string
      t.datetime :deadline
      t.text :description
      t.boolean :accomplished
      t.references :challenge, foreign_key: true
      t.timestamps
    end
  end
end
