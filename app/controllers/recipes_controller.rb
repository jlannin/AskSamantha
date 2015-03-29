class RecipesController < ApplicationController

def index
  @recipes = Recipe.order(:name)
end

def show
  @recipe = Recipe.find(params[:id])
end

end
