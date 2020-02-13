class SourceInIncome < ActiveRecord::Migration[6.0]
  def change
    add_column :incomes, :source, :string
  end
end
