class BasketPriceCalculator
  attr_reader :basket

  def initialize(basket)
    @basket = basket
  end

  def call
    total_price_cents = 0
    @basket.basket_items.each do |basket_item|
      total_price_cents +=
        if basket_item.product.buy_one_get_one_free?
          apply_buy_one_get_one_free(basket_item)
        else
          apply_bulk_discount(basket_item)
        end
    end
    total_price_cents
  end

  private

  def apply_buy_one_get_one_free(basket_item)
    discounted_quantity =
      if basket_item.quantity.even?
        basket_item.quantity / 2
      else
        (basket_item.quantity / 2) + 1
      end
    item_total_price(discounted_quantity, basket_item.product.price_cents)
  end

  def apply_bulk_discount(basket_item)
    bulk_discount = Product::BULK_DISCOUNTS.find { |discount| discount[:product_code] == basket_item.product.product_code }
    item_price =
      if bulk_discount && basket_item.quantity >= bulk_discount[:min_quantity]
        basket_item.product.price_cents * bulk_discount[:discount]
      else
        basket_item.product.price_cents
      end
    item_total_price(basket_item.quantity, item_price)
  end

  def item_total_price(quantity, price_cents)
    (quantity * price_cents).floor
  end
end
