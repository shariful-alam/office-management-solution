class AllocatedLeafe < ApplicationRecord
  belongs_to :user
  validates :total_leave, :presence => true
  validates :user_id, :presence => true, uniqueness: true
  validates :year, :presence => true
end
