class Attendance < ApplicationRecord

  belongs_to :user

  validates :date, uniqueness: {scope: :user_id}

end
