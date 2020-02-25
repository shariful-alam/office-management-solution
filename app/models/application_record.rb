class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  APPROVED = "approved"
  PENDING = "pending"
  REJECTED = "rejected"

end
