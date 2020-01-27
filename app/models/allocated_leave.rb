class AllocatedLeave < ApplicationRecord
  belongs_to :user
  validates :total_leave, :presence => true
end
