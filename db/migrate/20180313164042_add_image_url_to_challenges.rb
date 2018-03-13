class AddImageUrlToChallenges < ActiveRecord::Migration[5.1]
  def change
    add_column :challenges, :image_url, :string
  end
end
