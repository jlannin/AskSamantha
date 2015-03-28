class RecipesController < ApplicationController

	def index
  	@recipes = Recipe.order(:cooking_time)
	end

	

end
