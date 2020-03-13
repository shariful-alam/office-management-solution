class AddIndexInAllocatedLeafe < ActiveRecord::Migration[6.0]
  def change
    add_index :allocated_leaves, [:user_id, :year]
  end
end
