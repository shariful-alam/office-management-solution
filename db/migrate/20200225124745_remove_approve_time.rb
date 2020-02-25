class RemoveApproveTime < ActiveRecord::Migration[6.0]
  def change
    remove_column :leaves, :approve_time, :datetime
    remove_column :incomes, :approve_time, :datetime
    remove_column :expenses, :approve_time, :datetime
  end
end
