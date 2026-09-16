class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  validates :name, :sku, :price, :stock, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :sku, uniqueness: true

  scope :by_category, ->(category_id) { where(category_id: category_id) if category_id.present? }
  scope :by_price, ->(min, max) {
    scoped = all
    scoped = scoped.where("price >= ?", min) if min.present?
    scoped = scoped.where("price <= ?", max) if max.present?
    scoped
  }
  scope :in_stock, -> { where("stock > 0") }
end