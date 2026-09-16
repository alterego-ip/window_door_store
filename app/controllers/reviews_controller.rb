class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product

  def create
    @review = @product.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product), notice: "Ваш відгук успішно опубліковано!"
    else
      redirect_to product_path(@product), alert: @review.errors.full_messages.to_sentence
    end
  end

  def destroy
    @review = @product.reviews.find(params[:id])
    if @review.user == current_user || current_user.admin?
      @review.destroy
      redirect_to product_path(@product), notice: "Відгук видалено."
    else
      redirect_to product_path(@product), alert: "У вас немає прав для видалення цього відгуку."
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end