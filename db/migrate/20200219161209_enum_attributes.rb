class EnumAttributes < ActiveRecord::Migration[6.0]
  def change
    remove_column :expenses, :status, :string
    remove_column :leaves, :status, :string
    remove_column :incomes, :status, :string

    add_column :expenses, :status, :integer, default: 0
    add_column :leaves, :status, :integer, default: 0
    add_column :incomes, :status, :integer, default: 0
  end
end
