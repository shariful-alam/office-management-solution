class CreateLeaves < ActiveRecord::Migration[6.0]
  def change
    create_table :leaves do |t|
      t.date :start_date
      t.date :end_date
      t.text :reason
      t.string :leave_type
      t.boolean :status , default: false
      t.decimal :user_id

      t.timestamps
    end
  end
end
