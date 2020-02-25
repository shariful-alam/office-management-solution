class SetDefaultForStatusInLeaves < ActiveRecord::Migration[6.0]
  def change
    change_column :leaves, :status, :string, default: "pending"
  end
end
