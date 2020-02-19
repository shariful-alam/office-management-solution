class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :expenses
  has_many :incomes
  has_many :budgets
  has_many :leaves
  has_one :allocated_leafe
  has_many :attendances

  has_attached_file :image
  validates_attachment :image,
                       content_type: {content_type: /\Aimage\/.*\z/},
                       size: {less_than: 1.megabyte},
                       styles: {orginal: "300x300#", thumb: "100x100#"},
                       source_file_options: {regular: "-density 96 -depth 8 -quality 85"},
                       convert_options: {regular: "-posterize 3"}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ADMIN = "Admin"
  SUPER_ADMIN = "Super Admin"
  EMPLOYEE = "Employee"
  DESIGNATION_LIST = ['Junior Software Engineer', 'Senior Software Engineer', 'Office Admin', 'Chief Executive Officer', 'Chief Technical Officer']
  ROLE_LIST = ['Super Admin', 'Admin', 'Employee']


  attr_accessor :remove_image

  after_create :send_message
  before_save :delete_image, if: -> {remove_image == '1'}

  def admin?
    self.role == ADMIN
  end

  private

  def send_message
    UserMailer.welcome(self).deliver_now
  end

  def delete_image
     self.image = nil
  end


end
