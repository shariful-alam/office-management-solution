class Expense < ApplicationRecord
  validates :name, :presence => true
  belongs_to :user

  APPROVED = "Approved"
  PENDING = "Pending"
  CATEGORY_LIST = ["Fixed", "Regular"]


end
