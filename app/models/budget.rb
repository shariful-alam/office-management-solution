class Budget < ApplicationRecord

  belongs_to :user
  has_many :expenses
  attr_accessor :year, :add

  validates :month, :presence => true
  validates :month, :uniqueness => true
  validates :amount, :presence => true, numericality: {integer: true}
  validates :add, numericality: {integer: true, message: 'Please Give a value', :allow_blank => true, :allow_nil => true}

  before_create :define_month_year
  before_update :define_month_year

  private

  def define_month_year

    if year != nil
      self.month = month+', '+year

      if expense == nil
        self.expense = 0
      end

      if add != nil
        self.amount += add.to_i
      end

      validate validate! _validators
    end
  end

end
