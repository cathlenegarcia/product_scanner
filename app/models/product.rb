class Product < ApplicationRecord
  monetize :price_cents

  validates :name, :product_code, presence: true
  validates :product_code, uniqueness: true
end
