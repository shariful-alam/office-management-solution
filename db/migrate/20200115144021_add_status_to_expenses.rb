class AddStatusToExpenses < ActiveRecord::Migration[6.0]
  def change
    add_column :expenses, :status, :string ,default: "Pending"
  end
end
