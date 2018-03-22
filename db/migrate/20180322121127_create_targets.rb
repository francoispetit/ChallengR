class CreateTargets < ActiveRecord::Migration[5.1]
  def change
    create_table :targets do |t|
      t.references :subgoal, foreign_key: true
      t.string :unit
      t.integer :value

      t.timestamps
    end
  end
end
