FactoryBot.define do
  factory :cart_item do
    cart { nil }
    product { nil }
    custom_configuration { nil }
    quantity { 1 }
    unit_price { "9.99" }
  end
end
