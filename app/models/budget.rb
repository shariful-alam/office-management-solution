class Budget < ApplicationRecord
  validates :year, :presence => true
  validates :month, :presence => true
  belongs_to :user
  MONTH_LIST = ['Jan', 'Feb' ,'Mar', 'Apr' ,'May', 'Jun' ,'Jul', 'Aug' ,'Sep', 'Oct' ,'Nov', 'Dec' ]





  private
  def self.search(search)
    @key = "%#{search}%"

    self.joins(:user).where('users.name ilike :search OR month ilike :search OR CAST(year as varchar(20)) ilike :search', search: @key)
  end






end
