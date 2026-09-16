module Admin
  class OrdersController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_order, only: [:show, :update]

    def index
      @orders = Order.includes(:order_items, :user).order(created_at: :desc)
      @orders = @orders.where(status: params[:status]) if params[:status].present?
    end

    def show; end

    def update
      if @order.update(order_params)
        redirect_to admin_order_path(@order), notice: "Статус замовлення №#{@order.id.to_s.rjust(6, '0')} успішно оновлено."
      else
        redirect_to admin_order_path(@order), alert: "Не вдалося оновити статус."
      end
    end

    private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:status)
    end
  end
end