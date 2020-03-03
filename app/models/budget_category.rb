class BudgetCategory < ApplicationRecord
  has_many :budgets
  has_many :expenses
end
