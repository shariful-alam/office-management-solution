class Leafe < ApplicationRecord
  LEAVE_TYPE = ["Personal Leave", "Training", "Vacation", "Medical Leave"]
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :reason, presence: true
  validates :leave_type, presence: true
  APPROVED = "Approved"
  PENDING = "Pending"
  REJECTED = "Rejected"
  belongs_to :user
  PL = "Personal Leave"
  TL = "Training"
  VL = "Vacation"
  ML = "Medical Leave"

  scope :with_status, -> (status) { where(status: status) }

end
