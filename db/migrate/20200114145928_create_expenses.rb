class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.string :name
      t.string :category
      t.decimal :cost
      t.string :details
      t.string :employee
      t.timestamps
    end
  end
end
