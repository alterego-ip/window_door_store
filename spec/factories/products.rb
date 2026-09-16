FactoryBot.define do
  factory :product do
    category { nil }
    name { "MyString" }
    sku { "MyString" }
    price { "9.99" }
    stock { 1 }
    description { "MyText" }
    metadata { "" }
  end
end
