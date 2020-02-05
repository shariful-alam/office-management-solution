class Expense < ApplicationRecord

  validates :product_name, :presence => true
  validates :cost, :presence => true, numericality: {integer: true}
  has_attached_file :image
  validates_attachment :image,
                       content_type: {content_type: /\Aimage\/.*\z/},
                       size: {less_than: 1.megabyte},
                       styles: {orginal: "300x300#", thumb: "100x100#"},
                       source_file_options: {regular: "-density 96 -depth 8 -quality 85"},
                       convert_options: {regular: "-posterize 3"}
  belongs_to :user
  belongs_to :budget
  attr_accessor :remove_image
  before_save :delete_image, if: -> {remove_image == '1'}

  APPROVED = "Approved"
  PENDING = "Pending"
  REJECTED = "Rejected"
  CATEGORY_LIST = ["Fixed", "Regular"]

  private

  def self.search(from, to, search, page, user_id, role, status)
    if role == User::ADMIN or role == User::SUPER_ADMIN
      if search != "" and search !=nil
        @key = "%#{search}%"
        if from != "" and from != nil and to != "" and to != nil
          @from="#{from}"
          @to="#{to}"
          self.joins(:user).where(status: status).where('users.name ilike :search OR product_name ilike :search AND expense_date BETWEEN :from AND :to', from: @from, to: @to, search: @key).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
        else
          self.joins(:user).where(status: status).where('users.name ilike :search OR product_name ilike :search', search: @key).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
        end
      elsif from != "" and from != nil and to != "" and to != nil
        @from="#{from}"
        @to="#{to}"
        if search!= "" and search !=nil
          @key = "%#{search}%"
          self.joins(:user).where(status: status).where('users.name ilike :search OR product_name ilike :search AND expense_date BETWEEN :from AND :to', from: @from, to: @to, search: @key).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
        else
          self.joins(:user).where(status: status).where('expense_date BETWEEN :from AND :to', from: @from, to: @to).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
        end
      else
        self.joins(:user).where(status: status).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
      end
    else
      if search != "" and search !=nil
        @key = "%#{search}%"
        if from != "" and from != nil and to != "" and to != nil
          @from="#{from}"
          @to="#{to}"
          self.joins(:user).where(status: status, user_id: user_id).where('users.name ilike :search OR product_name ilike :search AND expense_date BETWEEN :from AND :to', from: @from, to: @to, search: @key).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
        else
          self.joins(:user).where(status: status, user_id: user_id).where('users.name ilike :search OR product_name ilike :search', search: @key).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
        end
      elsif from != "" and from != nil and to != "" and to != nil
        @from="#{from}"
        @to="#{to}"
        if search!= "" and search !=nil
          @key = "%#{search}%"
          self.joins(:user).where(status: status, user_id: user_id).where('users.name ilike :search OR product_name ilike :search AND expense_date BETWEEN :from AND :to', from: @from, to: @to, search: @key).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
        else
          self.joins(:user).where(status: status, user_id: user_id).where('expense_date BETWEEN :from AND :to', from: @from, to: @to).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
        end
      else
        self.joins(:user).where(status: status, user_id: user_id).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
      end
    end
  end


  def self.budget_expenses(from, to, search, page, id, status)
    if search != "" and search != nil
      @key = "%#{search}%"
      if from != "" and from != nil and to != "" and to != nil
        @from="#{from}"
        @to="#{to}"
        self.joins(:user).where(budget_id: id,status: status).where('users.name ilike :search OR product_name ilike :search AND expense_date BETWEEN :from AND :to', from: @from, to: @to, search: @key).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
      else
        self.joins(:user).where(budget_id: id,status: status).where('users.name ilike :search OR product_name ilike :search', search: @key).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
      end
    elsif from != "" and from != nil and to != "" and to != nil
      @from="#{from}"
      @to="#{to}"
      if search != "" and search !=nil
        @key = "%#{search}%"
        self.joins(:user).where(budget_id: id, status: status).where('users.name ilike :search OR product_name ilike :search AND expense_date BETWEEN :from AND :to', from: @from, to: @to, search: @key).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
      else
        self.joins(:user).where(budget_id: id, status: status).where('expense_date BETWEEN :from AND :to', from: @from, to: @to).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
      end
    else
      self.joins(:user).where(budget_id: id, status: status).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
    end
  end


  def self.user_expenses(from, to, search, page, id, status)
    if search != "" and search != nil
      @key = "%#{search}%"
      if from != "" and from != nil and to != "" and to != nil
        @from="#{from}"
        @to="#{to}"
        self.joins(:user).where(user_id: id,status: status).where('users.name ilike :search OR product_name ilike :search AND expense_date BETWEEN :from AND :to', from: @from, to: @to, search: @key).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
      else
        self.joins(:user).where(user_id: id,status: status).where('users.name ilike :search OR product_name ilike :search', search: @key).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
      end
    elsif from != "" and from != nil and to != "" and to != nil
      @from="#{from}"
      @to="#{to}"
      if search != "" and search !=nil
        @key = "%#{search}%"
        self.joins(:user).where(user_id: id, status: status).where('users.name ilike :search OR product_name ilike :search AND expense_date BETWEEN :from AND :to', from: @from, to: @to, search: @key).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
      else
        self.joins(:user).where(user_id: id, status: status).where('expense_date BETWEEN :from AND :to', from: @from, to: @to).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
      end
    else
      self.joins(:user).where(user_id: id, status: status).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
    end
  end


  def delete_image
    self.image = nil
  end


end
