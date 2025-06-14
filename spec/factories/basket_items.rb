FactoryBot.define do
  factory :basket_item do
    basket
    product
    quantity { Faker::Number.between(from: 1, to: 10) }
  end
end
