class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product, optional: true
  belongs_to :custom_configuration, optional: true

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }
  validate :must_have_either_product_or_custom_config

  def total_price
    quantity * unit_price
  end

  def item_title
    if product.present?
      product.name
    elsif custom_configuration.present?
      "Індивідуальне вікно (#{custom_configuration.width}x#{custom_configuration.height} мм)"
    else
      "Невідома позиція"
    end
  end

  private

  def must_have_either_product_or_custom_config
    if product.blank? && custom_configuration.blank?
      errors.add(:base, "Позиція повинна містити або готовий товар, або розрахунок калькулятора")
    end
  end
end