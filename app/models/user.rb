class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :expenses
  has_many :budgets
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  ADMIN = "Office Admin"
  ROLE_LIST = ['Junior Software Engineer', 'Senior Software Engineer', 'Office Admin', 'Chief Executive Officer', 'Chief technical Officer']
end
