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

def new
  @recipe = Recipe.new #possibly replace this witha helper 
end

def create
  ingredients = params[:recipe].delete(:ingredients)
  r= Recipe.new(create_params)
  if r.save
    flash[:notice] = "New recipe #{r.name} was made"
    redirect_to recipes_path
  else
    flash[:notice] = "The create didn't work :("
    redirect_to new_recipe_path
  end
end


def show
  @recipe = Recipe.find(params[:id])
end

#added simple edit metod to fix the null item error
def edit
  @recipe = Recipe.find(params[:id])
end

def update
  @recipe = Recipe.find(params[:id])
  @recipe.update(update_params)
  if @recipe.save#wont fail until we add validaitons or force in rspec tests
    flash[:notice] = "You updated #{@recipe.name}"
    redirect_to recipe_path(@recipe) #redirect to the show
  else
    flash[:notice] = "The update failed :("
    redirect_to edit_recipe_path(@recipe) #redirect back to the edit page
  end
end

private

#added but still need to add the validations in the class
def update_params
  #mess with ingredients eventually
  params.require(:recipe).permit(:name, :directions, :cooking_time, :image)
end

def create_params
  params.require(:recipe).permit(:name, :directions, :cooking_time, :image)
end


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
