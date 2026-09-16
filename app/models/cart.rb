class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy

  def total_price
    cart_items.sum(&:total_price)
  end

  def total_items_count
    cart_items.sum(:quantity)
  end
end