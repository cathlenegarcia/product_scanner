class BasketsController < ApplicationController
  def show
    @basket = current_basket
  end

  def add_item
    @basket = current_basket
    product = Product.find(params[:product_id])
    basket_item = @basket.basket_items.find_or_initialize_by(product: product)

    if basket_item.update(quantity: (basket_item.quantity || 0) + 1)
      total_price = BasketPriceCalculator.new(@basket).call
      @basket.update!(total_price_cents: total_price)
      render json: {
        success: true,
        basket_total: @basket.total_price.format,
        item_count: @basket.basket_items.sum(:quantity)
      }
    else
      render json: { success: false, errors: basket_item.errors }, status: :unprocessable_entity
    end
  end

  def remove_item
    @basket = current_basket
    basket_item = @basket.basket_items.find_by(product_id: params[:product_id])

    if basket_item
      if basket_item.quantity > 1
        basket_item.decrement!(:quantity)
      else
        basket_item.destroy!
      end

      total_price = BasketPriceCalculator.new(@basket).call
      @basket.update!(total_price_cents: total_price)

      render json: {
        success: true,
        basket_total: @basket.total_price.format,
        item_count: @basket.basket_items.sum(:quantity)
      }
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end

  private

  def current_basket
    session[:basket_id] ||= Basket.create!.id
    Basket.find(session[:basket_id])
  end
end
