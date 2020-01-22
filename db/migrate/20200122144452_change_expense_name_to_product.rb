class ChangeExpenseNameToProduct < ActiveRecord::Migration[6.0]
  def change
    rename_column :expenses, :name, :product_name
  end
end
