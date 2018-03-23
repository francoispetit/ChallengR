class CreateTargets < ActiveRecord::Migration[5.1]
  def change
    create_table :targets do |t|
      t.references :subgoal, foreign_key: true
      t.integer :value
      t.string :unit
      t.timestamps
    end
  end
end
