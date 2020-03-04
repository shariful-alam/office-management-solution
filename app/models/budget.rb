class Budget < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :expenses
  attr_accessor :add

  PER_PAGE = 12

  validates :month, presence: true
  validates :year, presence: true
  validates :month, uniqueness: {scope: [:year, :category_id] }
  validates :amount, presence: true, numericality: {integer: true}
  validates :add, numericality: {integer: true, message: 'Please Give a value', :allow_blank => true, :allow_nil => true}

  scope :search_with, -> (year, month) {where(year: year, month: month)}

  before_update :add_amount

  def add_amount
    self.amount += self.add.to_i if self.add.present?
  end

end
