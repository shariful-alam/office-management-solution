class Income < ApplicationRecord
  belongs_to :user
  validates :income_date, :presence => true
  validates :amount, :presence => true, numericality: {decimal: true}
end
