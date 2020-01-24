class Expense < ApplicationRecord
  validates :product_name, :presence => true
  validates :cost, :presence => true , numericality: { integer: true }
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
  CATEGORY_LIST = ["Fixed", "Regular"]

  private
  def self.search(search)
    @key = "%#{search}%"
    self.joins(:user).where('users.name ilike :search OR product_name ilike :search', search: @key)
  end
  def delete_image
    self.image = nil
  end



end
