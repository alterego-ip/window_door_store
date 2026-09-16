class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :nullify

  validates :name, :sku, presence: { message: "не може бути порожнім" }
  validates :sku, uniqueness: { message: "із таким артикулом уже існує в базі" }
  validates :price, numericality: { greater_than: 0, message: "має бути строго більшою за 0 грн" }
  validates :stock, numericality: { only_integer: true, greater_than: 0, message: "має бути не менше 1 шт." }

  has_many :reviews, dependent: :destroy

  def average_rating
    return 0.0 if reviews.empty?
    reviews.average(:rating).round(1)
  end
end