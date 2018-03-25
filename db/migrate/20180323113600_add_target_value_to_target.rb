class AddTargetValueToTarget < ActiveRecord::Migration[5.1]
  def change
    add_column :targets, :target_value, :integer
  end
end
