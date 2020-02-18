class Income < ApplicationRecord
  belongs_to :user
  validates :amount, :presence => true, numericality: {decimal: true}
  validates :income_date, :presence => true
  validates :source, :presence => true

  MONTHS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  SOURCE = ['Employee', 'Service']


  private

  def self.find_incomes_by_months(user, month,search)
    income = self.where(user_id: user.id, status: Income::APPROVED)
    income = income.where('extract(month from income_date) = ?', month)
    income = search.present? ?
      income.where('extract(year from income_date) = ?', search) :
      income.where('extract(year from income_date) = ?', Date.today.year)
    income = income.sum(:amount)
    return income.to_i
  end

  def self.find_total(user, search)
    i = Income.where(user_id: user.id, status: Income::APPROVED)
    if search.nil?
      @year = Date.today.year
      i = i.where('extract(year from income_date) = ?', @year).sum(:amount)
    else
      i = i.where('extract(year from income_date) = ?', search).sum(:amount)
    end
    return i.to_i
  end

  def self.bonus_amount(id,month,year)
    user = User.find(id)
    income = Income.where(user_id: user.id)
    income = income.with_status(Income::APPROVED)
    income = income.where('extract(month from income_date) = ?', month) if month.present?
    income = income.where('extract(year from income_date) = ?', year.present? ? year : Date.today.year) if year.present?
    income = income.sum(:amount)

    bonus = 0
    if income > user.target_amount
      bonus = (income - user.target_amount) * (user.bonus_percentage / 100.0)
    end
    return bonus
  end

end
