class Expense < ApplicationRecord
  validates :product_name, :presence => true
  belongs_to :user

  APPROVED = "Approved"
  PENDING = "Pending"
  CATEGORY_LIST = ["Fixed", "Regular"]




  private
  def self.search(search)
    @key = "%#{search}%"
    self.joins(:user).where('users.name ilike :search OR product_name ilike :search', search: @key)
  end

end
