FactoryBot.define do
  factory :order do
    user { nil }
    full_name { "MyString" }
    email { "MyString" }
    delivery_address { "MyString" }
    payment_method { "MyString" }
    total_price { "9.99" }
    status { 1 }
    notes { "MyText" }
  end
end
