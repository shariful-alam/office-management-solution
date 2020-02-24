class Leafe < ApplicationRecord

  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :reason, presence: true
  validates :leave_type, presence: true

  after_update :update_allocated_leave

  LEAVE_TYPES = ["Personal Leave", "Training", "Vacation", "Medical Leave"]

  PL = "Personal Leave"
  TL = "Training"
  VL = "Vacation"
  ML = "Medical Leave"

  enum status: {pending: 0, approved: 1, rejected: 2}

  scope :with_leafe_type, -> (type) {where(leave_type: type)}


  private

  def update_allocated_leave
    @count = count_days(self.start_date, self.end_date)
    @allocated_leafe = self.user.allocated_leafe
    if self.pending?
      @allocated_leafe.update({used_leave: @allocated_leafe.used_leave - @count})
    elsif self.approved?
      @allocated_leafe.update({used_leave: @allocated_leafe.used_leave + @count})
    end
  end

  def count_days(start_date, end_date)
    if start_date.present? and end_date.present?
      (start_date..end_date).select {|a| a.wday < 6 && a.wday > 0}.count
    else
      0
    end
  end


end
