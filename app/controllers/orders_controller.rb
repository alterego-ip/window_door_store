class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def new
    @cart = current_cart
    if @cart.cart_items.empty?
      redirect_to cart_path, alert: "Кошик порожній. Додайте товари перед оформленням."
      return
    end

    @order = Order.new
    if user_signed_in?
      @order.full_name = current_user.full_name
      @order.email = current_user.email
    end
  end

  def create
    @cart = current_cart
    if @cart.cart_items.empty?
      redirect_to cart_path, alert: "Кошик порожній."
      return
    end

    @order = Order.new(order_params)
    @order.user = current_user if user_signed_in?
    @order.total_price = @cart.total_price

    ActiveRecord::Base.transaction do
      @order.save!

      @cart.cart_items.each do |cart_item|
        @order.order_items.create!(
          product: cart_item.product,
          custom_configuration: cart_item.custom_configuration,
          quantity: cart_item.quantity,
          unit_price: cart_item.unit_price
        )

        if cart_item.product.present?
          cart_item.product.decrement!(:stock, cart_item.quantity)
        end
      end

      @cart.cart_items.destroy_all
    end

    redirect_to order_path(@order), notice: "Замовлення успішно зареєстровано в системі!"
  rescue ActiveRecord::RecordInvalid
    render :new, status: :unprocessable_entity
  end

  def show
    @order = Order.find(params[:id])
    if @order.user.present? && @order.user != current_user && (!user_signed_in? || !current_user.admin?)
      redirect_to root_path, alert: "Доступ до цієї специфікації обмежено."
    end
  end

  private

  def order_params
    params.require(:order).permit(:full_name, :email, :delivery_address, :payment_method, :notes)
  end
end