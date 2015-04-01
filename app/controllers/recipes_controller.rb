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

def create
  new_ingredients = params[:recipe].delete(:change_ingredients).split(",")
  r = Recipe.new(create_params)
  add_ingredients(new_ingredients, r, 0)
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
  new_ingredients = params[:recipe].delete(:change_ingredients).split(",")
  @recipe = Recipe.find(params[:id])
  r = @recipe
  index = update_ingredients(new_ingredients)
  if new_ingredients.length > @recipe.ingredients.length
    add_ingredients(new_ingredients, r, index)
  end
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

def add_ingredients(new_ingredients, r, start)
  new_ingredients[start..new_ingredients.length-1].each do |i|
    i =~ /\s?(.*)\s(\d*)$/
    hash = Hash.new
    hash[:name] = $1
    hash[:quantity] = $2
    r.ingredients.new(hash)
  end
end

def update_ingredients(new_ingredients)
  index = 0
  old_ingredients = @recipe.ingredients
  old_ingredients.each do |i|
    if index < new_ingredients.length
      new_ingredients[index] =~ /\s?(.*)\s(\d*)$/
      hash = Hash.new
      hash[:name] = $1
      hash[:quantity] = $2
      i.update(hash)
    else
      i.destroy
    end
    index += 1
  end
  index
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
