class CartItemsController < ApplicationController
  def create
    @cart = current_cart

    if params[:product_id].present?
      product = Product.find(params[:product_id])
      item = @cart.cart_items.find_by(product_id: product.id)
      if item
        item.increment!(:quantity)
      else
        @cart.cart_items.create!(product: product, unit_price: product.price, quantity: 1)
      end
      redirect_back fallback_location: products_path, notice: "Товар додано до замовлення."
    elsif params[:custom_configuration_id].present?
      config = CustomConfiguration.find(params[:custom_configuration_id])
      @cart.cart_items.create!(
        custom_configuration: config,
        unit_price: config.calculated_price,
        quantity: 1
      )
      redirect_back fallback_location: configurator_path, notice: "Розраховану конструкцію додано до замовлення."
    else
      redirect_back fallback_location: root_path, alert: "Помилка додавання позиції."
    end
  end

  def update
    @cart_item = current_cart.cart_items.find(params[:id])

    new_quantity = if params[:delta].present?
                     @cart_item.quantity + params[:delta].to_i
                   else
                     params[:quantity].to_i
                   end

    if new_quantity > 0
      @cart_item.update(quantity: new_quantity)
    else
      @cart_item.destroy
    end

    redirect_to cart_path
  end

  def destroy
    @cart_item = current_cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path, notice: "Позицію вилучено з кошика."
  end
end