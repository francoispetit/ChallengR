class CategoriesChallenges < ActiveRecord::Migration[5.1]
  def change
  	create_table :categories_challenges, id: false do |t|
      t.belongs_to :category, index: true
      t.belongs_to :challenge, index: true
  	end
  end
end
