class AddTargetAndBonusInUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :target_amount, :decimal
    add_column :users, :bonus_percentage, :decimal
  end
end
