class CustomConfiguration < ApplicationRecord
  validates :product_type, :width, :height, :profile_system, :glass_type, :hardware, presence: true
  validates :width, numericality: { only_integer: true, greater_than_or_equal_to: 400, less_than_or_equal_to: 3000 }
  validates :height, numericality: { only_integer: true, greater_than_or_equal_to: 400, less_than_or_equal_to: 2800 }
  validates :calculated_price, numericality: { greater_than: 0 }

  def area_m2
    (width * height) / 1_000_000.0
  end

  def perimeter_m
    (2 * (width + height)) / 1_000.0
  end
end