class Income < ApplicationRecord
  belongs_to :user
  validates :amount, :presence => true, numericality: {decimal: true}
  validates :income_date, :presence => true
  validates :source, :presence => true

  MONTHS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  SOURCE = ['Employee', 'Service']

  enum status: {pending: 0, approved: 1, rejected: 2}


  private

  def self.find_incomes_by_months(user, month, search)
    income = user.incomes.approved
    income = income.where('extract(month from income_date) = ?', month)
    if search.present?
      income = income.where('extract(year from income_date) = ?', search)
    else
      income.where('extract(year from income_date) = ?', Date.today.year)
    end
    income = income.sum(:amount)
  end

  def self.find_total(user, search)
    income = user.incomes.approved
    if search.nil?
      income = income.where('extract(year from income_date) = ?', Date.today.year)
    else
      income = income.where('extract(year from income_date) = ?', search)
    end
    income = income.sum(:amount)
  end

  def self.bonus_amount(user, month, year)
    income = user.incomes.approved
    income = income.where('extract(month from income_date) = ?', month) if month.present?
    income = income.where('extract(year from income_date) = ?', year.present? ? year : Date.today.year) if year.present?
    income = income.sum(:amount)

    bonus = 0
    if income > user.target_amount
      bonus = (income - user.target_amount) * (user.bonus_percentage / 100.0)
    end
    bonus
  end

end
