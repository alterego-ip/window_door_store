module Admin
  class ProductsController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_product, only: [:edit, :update, :destroy]

    def index
      @products = Product.includes(:category).order(created_at: :desc)
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to admin_products_path, notice: "Товар успішно додано!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @product.update(product_params)
        redirect_to admin_products_path, notice: "Товар оновлено!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @product.destroy
      redirect_to admin_products_path, notice: "Товар видалено!"
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :category_id, :sku, :price, :stock, :description, :image)
    end
  end
end