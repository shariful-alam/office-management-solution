class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  APPROVED = "Approved"
  PENDING = "Pending"
  REJECTED = "Rejected"

end
