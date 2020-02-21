class Leafe < ApplicationRecord

  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :reason, presence: true
  validates :leave_type, presence: true

  LEAVE_TYPES = ["Personal Leave", "Training", "Vacation", "Medical Leave"]

  PL = "Personal Leave"
  TL = "Training"
  VL = "Vacation"
  ML = "Medical Leave"

  enum status: { Pending: 0, Approved: 1, Rejected: 2 }

  scope :with_leafe_type, -> (type) { where(leave_type: type) }


  def self.count_days
    (self.start_date..self.end_date).select {|a| a.wday < 6 && a.wday > 0}.count
  end


end
