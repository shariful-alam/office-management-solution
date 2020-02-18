class Income < ApplicationRecord
  belongs_to :user
  validates :amount, :presence => true, numericality: {decimal: true}
  validates :income_date, :presence => true
  validates :source, :presence => true

  MONTHS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  SOURCE = ['Employee', 'Service']

  def self.find_incomes_by_months(user, month,search)
    income = self.where(user_id: user.id, status: Income::APPROVED)
    income = income.where('extract(month from income_date) = ?', month)
    income = search.present? ?
      income.where('extract(year from income_date) = ?', search) :
      income.where('extract(year from income_date) = ?', Date.today.year)
    income = income.sum(:amount)

    return income.to_i
  end

end
