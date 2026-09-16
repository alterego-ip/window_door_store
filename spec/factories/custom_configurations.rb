FactoryBot.define do
  factory :custom_configuration do
    product_type { "MyString" }
    width { 1 }
    height { 1 }
    profile_system { "MyString" }
    glass_type { "MyString" }
    hardware { "MyString" }
    with_installation { false }
    calculated_price { "9.99" }
    configuration_data { "" }
  end
end
