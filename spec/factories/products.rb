FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price }
    sequence(:product_code) { |n| "PROD-#{n}" }
  end
end
