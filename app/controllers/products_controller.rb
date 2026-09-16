class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.includes(:category)

    if params[:query].present?
      @products = @products.where("name ILIKE :q OR sku ILIKE :q OR description ILIKE :q", q: "%#{params[:query]}%")
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    min_p = params[:min_price].presence&.to_f
    max_p = params[:max_price].presence&.to_f

    if min_p && max_p && min_p > max_p
      min_p, max_p = max_p, min_p
      flash.now[:alert] = "Початкову та кінцеву ціну було автоматично впорядковано."
    end

    @products = @products.where("price >= ?", min_p) if min_p
    @products = @products.where("price <= ?", max_p) if max_p
  end

  def show
    @product = Product.find(params[:id])
  end
end