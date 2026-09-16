class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all.with_attached_image

    @products = @products.by_category(params[:category_id])
    @products = @products.by_price(params[:min_price], params[:max_price])

    if params[:query].present?
      @products = @products.where("name ILIKE ?", "%#{params[:query]}%")
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end