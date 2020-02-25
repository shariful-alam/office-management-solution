class AddDateInAttendance < ActiveRecord::Migration[6.0]
  def change
    remove_column :attendances, :info, :string
    add_column :attendances, :date, :date
    add_index :attendances, [:user_id, :date]
  end
end
