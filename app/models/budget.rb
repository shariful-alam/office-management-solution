class Budget < ApplicationRecord
  validates :year, :presence => true
  validates :month, :presence => true
  belongs_to :user
  MONTH_LIST = ['Jan', 'Feb' ,'Mar', 'Apr' ,'May', 'Jun' ,'Jul', 'Aug' ,'Sep', 'Oct' ,'Nov', 'Dec' ]
end
