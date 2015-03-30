class RecipesController < ApplicationController

def index
    if params[:query] != nil
      session[:query] = params[:query]
    end
    if params[:cooking_time] != nil
      session[:cooking_time] = params[:cooking_time]
    end
    handle_redirects
    if params[:query] == nil
      @recipes = Recipe.filter(params[:cooking_time]).sorted_by("name")
    else
      @recipes = Recipe.filter(params[:cooking_time]).sorted_by(params[:query])
    end
end

def show
  @recipe = Recipe.find(params[:id])
end

private

def handle_redirects
  if !params.has_key?(:cooking_time) && session.has_key?(:cooking_time) && session[:cooking_time] != ""
    flash.keep
    if session.has_key?(:query)
      redirect_to recipes_path(:cooking_time => session[:cooking_time], :query => session[:query]) and return
    else
      redirect_to recipes_path(:cooking_time => session[:cooking_time]) and return
    end
  else
    if !params.has_key?(:query) && session.has_key?(:query)
      flash.keep
      redirect_to recipes_path(:cooking_time => params[:cooking_time], :query => session[:query]) and return
    end
  end
end

end
