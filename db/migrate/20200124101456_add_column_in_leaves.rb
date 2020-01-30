class AddColumnInLeaves < ActiveRecord::Migration[6.0]
  def change
    add_column :leaves, :approve_time, :time
  end
end
