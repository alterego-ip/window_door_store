class CartsController < ApplicationController
  def show
    @cart = current_cart
  end

  def destroy
    @cart = current_cart
    @cart.cart_items.destroy_all
    redirect_to cart_path, notice: "Кошик повністю очищено."
  end
end