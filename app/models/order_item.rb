class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product, optional: true
  belongs_to :custom_configuration, optional: true

  def total_price
    quantity * unit_price
  end

  def item_title
    if product.present?
      product.name
    elsif custom_configuration.present?
      "Індивідуальна конструкція (#{custom_configuration.width}x#{custom_configuration.height} мм)"
    else
      "Позиція без назви"
    end
  end
end