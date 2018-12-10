class ReviewsController < ApplicationController
  before_action :authorize
  
  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @review = @product.reviews.find(current_user)
    @review.destroy
    # redirect_to :root, notice 'Comment deleted'
  end

  private
    def review_params
      params.require(:review).permit(:description, :rating)
    end
end
