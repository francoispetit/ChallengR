class AddUnitIdToTarget < ActiveRecord::Migration[5.1]
  def change
    add_column :targets, :unit_id, :integer
  end
end
