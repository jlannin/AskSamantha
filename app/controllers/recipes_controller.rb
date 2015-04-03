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
  @recipe = Recipe.new #possibly replace this with a helper 
end


def del_ing
  
  
  
#=begin
  if params.has_key?(:additional)
  #case 1 : trying to delete an additional
  #case 2 : trying to delete something saved to db
    Ingredient.find(params[:ing_id]).destroy
  else
    Ingredient.find(params[:ing_id]).destroy
  end	# end statement appears to be missing here. I'm not sure what you're trying to do here
  redirect_to edit_recipe_path(Recipe.find(params[:id]), :additional => params[:additional])
#=end
end


def create

=begin
  new_ingredients = params[:recipe].delete(:change_ingredients).split(",")
  r = Recipe.new(create_params)
  add_ingredients(new_ingredients, r, 0)#add this in later
=end
  ingredient_quantities = params.delete(:ingreds)
  ingredient_names = params.delete(:dropdown)
  r=Recipe.new(create_params)
  
  r.update_newingredients(ingredient_quantities, ingredient_names)
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
  #byebug
  ingredient_quantities = params.delete(:ingreds)
  ingredient_names = params.delete(:dropdown)
  newingredient_updates = params.delete(:new_ingreds)
  newingredient_names = params.delete(:new_dropdown)
  @recipe = Recipe.find(params[:id])
  @recipe.update_ingredients(ingredient_quantities, ingredient_names)
  @recipe.update_newingredients(newingredient_updates, newingredient_names)
  @recipe.update(update_params)
  if @recipe.save#wont fail until we add validations or force in rspec tests
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
