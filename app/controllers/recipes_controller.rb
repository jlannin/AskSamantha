class RecipesController < ApplicationController

def index
    handle_redirects
    if params[:query] == nil
      @recipes = Recipe.sorted_by("name")
    else
      @recipes = Recipe.sorted_by(params[:query])
    end
end

def show
  @recipe = Recipe.find(params[:id])
end

private

def handle_redirects
  if !params.has_key?(:query) && session.has_key?(:query)
    flash.keep
    redirect_to recipes_path(:query => session[:query]) and return
  end
end

end
