class Leafe < ApplicationRecord
  LEAVE_TYPE = ["Personal Leave", "Training", "Vacation", "Medical Leafe"]
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :reason, presence: true
  validates :leave_type, presence: true
  APPROVED = "Approved"
  PENDING = "Pending"
  REJECTED = "Rejected"
  belongs_to :user


  private
  def self.search_in_date_range(date_from, date_to)
    raise self.where(:start_date => date_from..date_to).inspect
  end

=begin
  def self.search(search)
    @key = "%#{search}%"
    self.joins(:user).where('users.name ilike :search OR leave_type ilike :search', search: @key)
  end
=end


  def self.search(from, to, search, user_id, role, status, page)

    if role == User::ADMIN or role == User::SUPER_ADMIN
      if search != "" and search !=nil
        @key = "%#{search}%"
        if from != "" and from != nil and to != "" and to != nil
          @from="#{from}"
          @to="#{to}"
          self.joins(:user).where(status: status).where('users.name ilike :search OR leave_type ilike :search', search: @key).where(':from <= end_date AND :to >= start_date', from: @from, to: @to).order('id ASC').paginate(:page => page, :per_page => 20)
        else
          self.joins(:user).where(status: status).where('users.name ilike :search OR leave_type ilike :search', search: @key).order('id ASC').paginate(:page => page, :per_page => 20)
        end
      elsif from != "" and from != nil and to != "" and to != nil
        @from="#{from}"
        @to="#{to}"
        if search!= "" and search !=nil
          @key = "%#{search}%"
          self.joins(:user).where(status: status).where('users.name ilike :search OR leave_type ilike :search', search: @key).where(':from <= end_date AND :to >= start_date', from: @from, to: @to).order('id ASC').paginate(:page => page, :per_page => 20)
        else
          self.joins(:user).where(status: status).where(':from <= end_date AND :to >= start_date', from: @from, to: @to).order('id ASC').paginate(:page => page, :per_page => 20)
        end
      else
        self.joins(:user).where(status: status).order('id ASC').paginate(:page => page, :per_page => 20)
      end
    else
      if search != "" and search !=nil
        @key = "%#{search}%"
        if from != "" and from != nil and to != "" and to != nil
          @from="#{from}"
          @to="#{to}"
          self.joins(:user).where(status: status, user_id: user_id).where('users.name ilike :search OR leave_type ilike :search', search: @key).where(':from <= end_date AND :to >= start_date', from: @from, to: @to).order('id ASC').paginate(:page => page, :per_page => 20)
        else
          self.joins(:user).where(status: status, user_id: user_id).where('users.name ilike :search OR leave_type ilike :search', search: @key).order('id ASC').paginate(:page => page, :per_page => 20)
        end
      elsif from != "" and from != nil and to != "" and to != nil
        @from="#{from}"
        @to="#{to}"
        if search!= "" and search !=nil
          @key = "%#{search}%"
          self.joins(:user).where(status: status, user_id: user_id).where('users.name ilike :search OR leave_type ilike :search', search: @key).where(':from <= end_date AND :to >= start_date', from: @from, to: @to).order('id ASC').paginate(:page => page, :per_page => 20)
        else
          self.joins(:user).where(status: status, user_id: user_id).where(':from <= end_date AND :to >= start_date', from: @from, to: @to).order('id ASC').paginate(:page => page, :per_page => 20)
        end
      else
        self.joins(:user).where(status: status, user_id: user_id).order('id ASC').paginate(:page => page, :per_page => 20)
      end
    end
  end


end
