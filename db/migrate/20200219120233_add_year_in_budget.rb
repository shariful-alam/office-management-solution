class AddYearInBudget < ActiveRecord::Migration[6.0]
  def up
    remove_column :budgets, :month, :string
    add_column :budgets, :month, :integer
    add_column :budgets, :year, :integer
    add_index :budgets, [:month, :year]
    remove_column :budgets, :expense, :decimal
    add_column :budgets, :expense, :decimal , default: 0
  end
  def down
    remove_index :budgets, [:month, :year]
    remove_column :budgets, :month, :integer
    add_column :budgets, :month, :string
    remove_column :budgets, :year, :integer
    remove_column :budgets, :expense, :decimal , default: 0
    add_column :budgets, :expense, :decimal
  end
end
