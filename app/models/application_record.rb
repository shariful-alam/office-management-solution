class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  APPROVED = "Approved"
  PENDING = "Pending"
  REJECTED = "Rejected"

  scope :with_status, -> (status) { where(status: status) }
  scope :with_leafe_type, -> (type) { where(leave_type: type) }
end
