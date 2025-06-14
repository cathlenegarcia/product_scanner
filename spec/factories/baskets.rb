FactoryBot.define do
  factory :basket do
    total_price { Faker::Number.between(from: 1, to: 1000) }
  end
end
