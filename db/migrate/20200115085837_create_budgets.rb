class CreateBudgets < ActiveRecord::Migration[6.0]
  def change
    create_table :budgets do |t|
      t.integer :year
      t.string :month
      t.decimal :amount
      t.decimal :remaining
      t.string :admin

      t.timestamps
    end
  end
end
