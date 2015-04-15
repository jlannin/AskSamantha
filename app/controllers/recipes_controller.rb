class RecipesController < ApplicationController

def index
    if params[:query] != nil
      session[:query] = params[:query]
    end
    if params[:cooking_time] != nil
      session[:cooking_time] = params[:cooking_time]
    end
    if params[:recipe_name] != nil
      session[:recipe_name] = params[:recipe_name]
    end
    redirect = handle_redirects
    if !redirect
      if params[:query] == nil
        @recipes = Recipe.filter(params[:cooking_time]).search(params[:recipe_name]).sorted_by("name")
      else
        @recipes = Recipe.filter(params[:cooking_time]).search(params[:recipe_name]).sorted_by(params[:query])
      end
      if @recipes.length == 0
        reset_search
      end
    end
end

def new
  @recipe = Recipe.new #possibly replace this with a helper 
end


def del_ing
  Ingredient.find(params[:ing_id]).destroy
  redirect_to edit_recipe_path(Recipe.find(params[:id]), :additional => params[:additional])
end


def create
  ingredient_quantities = params.delete(:ingreds)
  ingredient_names = params.delete(:dropdown)
  r=Recipe.new(create_params)
  r.update_newingredients(ingredient_quantities, ingredient_names)
  if r.save
    flash[:notice] = "New recipe #{r.name} was made"
    redirect_to recipes_path
  else
    flash[:notice] = "The create didn't work :(  "
    flash[:notice] << r.errors.full_messages.join(". ") << "."
    redirect_to new_recipe_path(:additional => 1)
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
    flash[:notice] = "The update failed :(   "
    flash[:notice] << @recipe.errors.full_messages.join(". ") << "."
    if @recipe.errors.has_key?(:need_at_least_one_ingredient)
      redirect_to edit_recipe_path(@recipe, {:additional => 1}) #redirect back to the edit page
    else
      redirect_to edit_recipe_path(@recipe)
    end
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
  hash = Hash.new
  redirect = false
  if !params.has_key?(:cooking_time) && session.has_key?(:cooking_time) && session[:cooking_time] != ""
    hash[:cooking_time] = session[:cooking_time]
    hash[:query] = params[:query] unless !params.has_key?(:query)
    hash[:recipe_name] = params[:recipe_name] unless !params.has_key?(:recipe_name)
    redirect = true
  end
  #should have cooking time set
  if !params.has_key?(:query) && session.has_key?(:query) && session[:query] != ""
    hash[:query] = session[:query]
    hash[:cooking_time] = params[:cooking_time] unless !params.has_key?(:cooking_time)
    hash[:recipe_name] = params[:recipe_name] unless !params.has_key?(:recipe_name)
    redirect = true
  end
  if !params.has_key?(:recipe_name) && session.has_key?(:recipe_name) && session[:recipe_name] != ""
    hash[:recipe_name] = session[:recipe_name]
    hash[:cooking_time] = params[:cooking_time] unless !params.has_key?(:cooking_time)
    hash[:query] = params[:query] unless !params.has_key?(:query)
    redirect = true
  end
  if redirect
    flash.keep
    redirect_to recipes_path(hash)
    true
  else

    false
  end
end

def reset_search
  flash[:notice] = "No recipes found"
  hash = Hash.new
  hash[:recipe_name] = ""
  hash[:cooking_time] = ""
  redirect_to recipes_path(hash) and return
end
end
