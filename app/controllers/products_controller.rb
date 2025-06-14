class ProductsController < ApplicationController
  def index
    @basket = current_basket
    @products = Product.all
  end

  private

  def current_basket
    session[:basket_id] ||= Basket.create!.id
    Basket.find(session[:basket_id])
  end
end
