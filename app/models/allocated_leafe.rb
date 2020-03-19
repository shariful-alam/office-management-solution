class AllocatedLeafe < ApplicationRecord

  belongs_to :user

  validates :total_leave, :presence => true , numericality: {integer: true}
  validates :user_id, :presence => true
  validates :year, :presence => true
  validates :year, uniqueness: {scope: [:user_id] }

  def allocated_leaves_count_for(user)
   leaves = user.leaves.approved
   {
      personal:  leaves.with_leafe_type(Leafe::PL).count,
      training:  leaves.with_leafe_type(Leafe::TL).count,
      vacation:  leaves.with_leafe_type(Leafe::VL).count,
      medical:  leaves.with_leafe_type(Leafe::ML).count
    }
  end

end
