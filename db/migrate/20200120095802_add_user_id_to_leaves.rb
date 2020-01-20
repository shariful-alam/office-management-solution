class AddUserIdToLeaves < ActiveRecord::Migration[6.0]
  def change
    change_column :leaves, :user_id, :integer
  end
end