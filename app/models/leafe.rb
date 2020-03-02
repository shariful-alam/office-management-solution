class Leafe < ApplicationRecord

  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :reason, presence: true
  validates :leave_type, presence: true


  LEAVE_TYPES = ["Personal Leave", "Training", "Vacation", "Medical Leave"]

  PL = "Personal Leave"
  TL = "Training"
  VL = "Vacation"
  ML = "Medical Leave"

  enum status: {pending: 0, approved: 1, rejected: 2}

  scope :with_leafe_type, -> (type) {where(leave_type: type)}

  after_create :admin_approval


  def update_allocated_leave
    count = Leafe.count_days(self.start_date, self.end_date)
    used = self.user.allocated_leafe.used_leave
    total = self.user.allocated_leafe.total_leave
    if self.pending?
      self.user.allocated_leafe.update({used_leave: (used - count >= 0 ? used - count : 0) })
    elsif self.approved?
      self.user.allocated_leafe.update({used_leave: (used + count <= total ? used + count : total) })
    end
  end

  private

  def self.count_days(start_date, end_date)
    if start_date.present? and end_date.present?
      (start_date..end_date).select {|a| a.wday < 6 && a.wday > 0}.count
    else
      0
    end
  end

  def admin_approval
    if self.user.admin? or self.user.super_admin?
      self.approved!
    end
  end


end
