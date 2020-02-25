class Income < ApplicationRecord
  belongs_to :user
  validates :amount, :presence => true, numericality: {decimal: true}
  validates :income_date, :presence => true
  validates :source, :presence => true

  MONTHS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  SOURCE = ['Employee', 'Service']

  enum status: {pending: 0, approved: 1, rejected: 2}


  scope :find_in_income_date_by, -> (value,search) { where('extract(? from income_date) = ?', value, search) }

  private

  def self.find_incomes_by_months(user, month, search)
    income = user.incomes.approved
               .find_in_income_date_by('month',month)
               .find_in_income_date_by('year', search.present? ? search : Date.today.year)
               .sum(:amount)
  end

  def self.find_total(user, search)
    income = user.incomes.approved
               .find_in_income_date_by('year', search.present? ? search : Date.today.year)
               .sum(:amount)
  end

  def self.bonus_amount(user, month, year)
    income = user.incomes.approved.find_in_income_date_by('year', year.present? ? year : Date.today.year)
    income = income.find_in_income_date_by('month',month) if month.present?
    income = income.sum(:amount)

    bonus = 0
    if income > user.target_amount
      bonus = (income - user.target_amount) * (user.bonus_percentage / 100.0)
    end
    bonus
  end

end
