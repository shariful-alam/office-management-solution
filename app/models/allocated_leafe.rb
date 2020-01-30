class AllocatedLeafe < ApplicationRecord
  belongs_to :user
  validates :total_leave, :presence => true
  validates :user_id, uniqueness: true
end
