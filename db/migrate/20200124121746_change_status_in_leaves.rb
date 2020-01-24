class ChangeStatusInLeaves < ActiveRecord::Migration[6.0]
  def change
    change_column :leaves, :status, :string, default: "Pending"
  end
end
