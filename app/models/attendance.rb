class Attendance < ApplicationRecord

  belongs_to :user
  validates :info, presence: true, uniqueness: true

end
