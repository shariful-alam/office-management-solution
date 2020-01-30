class CreateIncomes < ActiveRecord::Migration[6.0]
  def change
    create_table :incomes do |t|
      t.integer :user_id
      t.decimal :amount
      t.date :income_date
      t.string :year_month
      t.string :status, default: "Pending"
      t.datetime :approve_time
      t.timestamps
    end
  end
end
