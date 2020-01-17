class AddUserIdToExpenses < ActiveRecord::Migration[6.0]
  def change
    add_column :expenses, :user_id, :integer
    remove_column :expenses, :employee, :string
  end
end
