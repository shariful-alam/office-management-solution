class ChangeCategoryName < ActiveRecord::Migration[6.0]
  def change
    remove_column :expenses, :category, :string
    remove_column :categories, :category_name, :string
    add_column :categories, :name, :string
  end
end
