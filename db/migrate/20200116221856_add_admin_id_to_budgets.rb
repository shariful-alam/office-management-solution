class AddAdminIdToBudgets < ActiveRecord::Migration[6.0]
  def change
    add_column :budgets, :user_id, :integer
    remove_column :budgets, :admin, :string
  end
end
