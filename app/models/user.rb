class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :expenses
  has_many :budgets
  has_attached_file :image
  validates_attachment :image,
                       content_type: {content_type: /\Aimage\/.*\z/},
                       size: {less_than: 1.megabyte},
                       styles: {
                           thumb: ["100x100#", :jpeg],
                           original: [:jpeg]
                       },
                       convert_options: {
                           thumb: "-quality 70 -strip",
                           original: "-quality 90"
                       }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  ADMIN = "Office Admin"
  ROLE_LIST = ['Junior Software Engineer', 'Senior Software Engineer', 'Office Admin', 'Chief Executive Officer', 'Chief technical Officer']

  after_create :send_message

  private
  def send_message
    UserMailer.welcome(self).deliver_now
  end

end
