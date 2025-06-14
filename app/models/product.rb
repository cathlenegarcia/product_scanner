# frozen_string_literal: true

class Product < ApplicationRecord
  monetize :price_cents

  validates :name, :product_code, presence: true
  validates :product_code, uniqueness: true

  BULK_DISCOUNTS = [
    { product_code: 'SR1', min_quantity: 3, discount: 0.9 },
    { product_code: 'CF1', min_quantity: 3, discount: 0.66667 }
  ].freeze

  BUY_ONE_GET_ONE_PRODUCTS = ['GR1'].freeze

  def buy_one_get_one_free?
    BUY_ONE_GET_ONE_PRODUCTS.include?(product_code)
  end

  def bulk_discount?
    BULK_DISCOUNTS.any? { |discount| product_code == discount[:product_code] }
  end
end
