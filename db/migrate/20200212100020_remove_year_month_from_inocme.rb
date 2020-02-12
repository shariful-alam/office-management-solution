class RemoveYearMonthFromInocme < ActiveRecord::Migration[6.0]
  def change
    remove_column :incomes, :year_month, :string
  end
end
