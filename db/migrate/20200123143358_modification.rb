class Modification < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
      t.integer :user_id
      t.string :info
      t.timestamps
      end
    create_table :allocated_leaves do |t|
      t.integer :user_id
      t.integer :total_leave
      t.integer :used_leave, default: 0
      t.timestamps
    end
    add_column :expenses, :image_file_name, :string
    add_column :expenses, :image_content_type, :string
    add_column :expenses, :image_file_size, :integer
    add_column :expenses, :image_updated_at, :datetime
    add_column :expenses, :budget_id, :integer
    remove_column :budgets, :year, :integer
  end
end
