class ChangeApproveTimeType < ActiveRecord::Migration[6.0]
  def change
    remove_column :leaves, :approve_time, :time
    add_column :leaves, :approve_time, :datetime
  end
end
