class ApprovalTimeForExpenseChangeRemainingToExpenseForBudget < ActiveRecord::Migration[6.0]
  def change
    add_column :expenses, :approve_time, :datetime
    rename_column :budgets, :remaining, :expense
  end
end
