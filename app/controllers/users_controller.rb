class UsersController < ApplicationController

  def show_fridge
    @groceries = @user.groceries if @user
  end

  def edit_fridge
  end

  def del_groc
    Grocery.find(params[:groc_id]).destroy
    redirect_to edit_fridge_path(:additional => params[:additional])
  end

  def update
    old_grocs = params.delete(:oldgrocs)
    @user.update_fridge(old_grocs)
    new_grocs = params.delete(:newgrocs)
    @user.update_fridge_new(new_grocs) if new_grocs
    if @user.save  #wont fail until we add validations or force in rspec tests
      flash[:notice] = "Fridge successfully updated!"
      redirect_to show_fridge_path
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
  
end
