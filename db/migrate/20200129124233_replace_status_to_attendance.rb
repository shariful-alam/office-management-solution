class ReplaceStatusToAttendance < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :availability, :boolean
    add_column :attendances, :status, :boolean, default: false
  end
end
