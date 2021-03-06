class ReviewsController < ApplicationController
before_filter :authenticate_user!
   def create
      @recipe = Recipe.find(params[:recipe_id])
      params[:review][:user_id] = @user.id
      @review = Review.new(create_update_params)
      @recipe.update_avg_rating(@review.stars)
      @recipe.reviews << @review
      if @recipe.save
         flash[:notice] = 'Review successfully created!'
         redirect_to(recipe_path(@recipe))
      else
         flash[:notice] = 'Failure to create new review! '
         flash[:notice] << @review.errors.full_messages.join(". ") << "."
         redirect_to(new_recipe_review_path(@recipe))
      end
   end

   def new
      @recipe = Recipe.find(params[:recipe_id])
      @review = Review.new
   end

private
   def create_update_params
      params.require(:review).permit(:stars, :comments, :user_id)
   end
end
