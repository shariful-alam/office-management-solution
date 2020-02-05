class AddYearInLeafe < ActiveRecord::Migration[6.0]
  def change
    add_column :allocated_leaves, :year, :string
  end
end
