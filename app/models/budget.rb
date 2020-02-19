class Budget < ApplicationRecord

  belongs_to :user
  has_many :expenses
  attr_accessor :add

  validates :month, presence: true
  validates :year, presence: true
  validates :month, uniqueness: {scope: :year}
  validates :amount, presence: true, numericality: {integer: true}
  validates :add, numericality: {integer: true, message: 'Please Give a value', :allow_blank => true, :allow_nil => true}

  before_update :define_month_year

  private

  def define_month_year
    self.amount += add.to_i if add.present?
  end

end
