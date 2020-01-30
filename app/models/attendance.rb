class Attendance < ApplicationRecord
  validates :info, presence: true, uniqueness: true
  belongs_to :user
end
