class BasketPriceCalculator
  attr_reader :basket

  def initialize(basket)
    @basket = basket
  end

  def call
    basket.total_price_cents = basket.basket_items.sum do |item|
      item.product.price_cents * item.quantity
    end
  end
end
