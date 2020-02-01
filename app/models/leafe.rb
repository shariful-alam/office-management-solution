class Leafe < ApplicationRecord
  LEAVE_TYPE = ["Personal Leave", "Training", "Vacation", "Medical Leafe"]
  validates :start_date , presence: true
  validates :end_date , presence: true
  validates :reason , presence: true
  validates :leave_type , presence: true
  APPROVED = "Approved"
  PENDING = "Pending"
  REJECTED = "Rejected"
  belongs_to :user


  private
  def self.search_in_date_range(date_from, date_to)
    self.where(:start_date => date_from..date_to)
  end

  def self.search(search)
    @key = "%#{search}%"
    self.joins(:user).where('users.name ilike :search OR leave_type ilike :search', search: @key)
  end

end
