class CreateChallenges < ActiveRecord::Migration[5.1]
  def change
    create_table :challenges do |t|
      t.string :goal
      t.datetime :duedate
      t.boolean :accomplished
      t.references :organizer, references: :user
      t.timestamps
    end
  end
end
