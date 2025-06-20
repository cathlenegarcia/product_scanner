class Basket < ApplicationRecord
  monetize :total_price_cents

  has_many :basket_items, dependent: :destroy
  has_many :products, through: :basket_items
end
