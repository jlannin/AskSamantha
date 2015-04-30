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
    byebug
    add = params.delete(:additional)
    old_grocs = params.delete(:oldgrocs)
    @user.update_fridge(old_grocs) if old_grocs
    new_grocs = params.delete(:newgrocs)
    new_added=0
    new_added= @user.update_fridge_new(new_grocs) if new_grocs
    if @user.save  #wont fail until we add validations or force in rspec tests
      flash[:notice] = "Fridge successfully updated!"
      if add 
        #byebug
        add = add.keys[0].to_i
        draw= add-new_added
        redirect_to edit_fridge_path(:additional => "#{draw}")
      else
        redirect_to show_fridge_path
      end
    else
      flash[:notice] = "Fridge update failed :("
      redirect_to edit_fridge_path
    end
  end
  
end
