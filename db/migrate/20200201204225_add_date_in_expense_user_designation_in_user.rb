class AddDateInExpenseUserDesignationInUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :designation, :string
    add_column :expenses, :expense_date, :date
  end
end
