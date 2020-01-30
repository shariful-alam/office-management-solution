class AddStatusToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :availability, :boolean, default: false
  end
end
