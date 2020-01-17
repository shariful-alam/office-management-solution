class Leave < ApplicationRecord

  LEAVE_TYPE = ["Personal Leave", "Training", "Vacation", "Medical Leave"]

  validates :start_date , presence: true
  validates :end_date , presence: true
  validates :reason , presence: true
  validates :leave_type , presence: true


  belongs_to :user

end
