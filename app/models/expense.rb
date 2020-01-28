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
  attr_accessor :remove_image, :year, :month, :late
  before_save :delete_image, if: -> {remove_image == '1'}

  APPROVED = "Approved"
  PENDING = "Pending"
  REJECTED = "Rejected"
  CATEGORY_LIST = ["Fixed", "Regular"]

  private
  def self.search(search, page, user_id, role)
    if role == User::ADMIN
      if search
        @key = "%#{search}%"
        self.joins(:user).where('users.name ilike :search OR product_name ilike :search', search: @key).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
      else
        self.order('expenses.id ASC').paginate(:page => page, :per_page => 20)
      end
    else
      if search
        @key = "%#{search}%"
        self.joins(:user).where(user_id: user_id).where('users.name ilike :search OR product_name ilike :search', search: @key).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
      else
        self.where(user_id: user_id).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
      end
    end
  end

  def self.status_expenses(search, page, id, status)
    if search
      @key = "%#{search}%"
      self.joins(:user).where(budget_id: id, status: status).where('users.name ilike :search OR product_name ilike :search', search: @key).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
    else
      self.where(budget_id: id, status: status).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
    end
  end

  def self.user_expenses(search, page, id, status)
    if search
      @key = "%#{search}%"
      self.joins(:user).where(user_id: id, status: status).where('users.name ilike :search OR product_name ilike :search', search: @key).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
    else
      self.where(user_id: id, status: status).order('expenses.id ASC').paginate(:page => page, :per_page => 20)
    end
  end


  def delete_image
    self.image = nil
  end


end
