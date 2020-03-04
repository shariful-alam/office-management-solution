class ModifyBudgetExpense < ActiveRecord::Migration[6.0]

  def up
    remove_index :budgets, [:month, :year]
    add_column :budgets, :category_id, :integer
    add_column :expenses, :category_id, :integer
    add_index :budgets, [:month, :year , :category_id]
  end

  def down
    remove_index :budgets, [:month, :year , :category_id]
    remove_column :budgets, :category_id, :integer
    remove_column :expenses, :category_id, :integer
    add_index :budgets, [:month, :year]
  end
end
