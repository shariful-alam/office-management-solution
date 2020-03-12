class Attendance < ApplicationRecord

  belongs_to :user

  validates :date, uniqueness: {scope: :user_id}

  OFFICE_IP_ADDRESSES = ["27.147.206.53"]
  LOCALHOST_IP_ADDRESS = ['::1','127.0.0.1']

end
