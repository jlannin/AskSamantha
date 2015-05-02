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
    add = params.delete(:additional)
    old_grocs = params.delete(:oldgrocs)
    if old_grocs
      error = @user.update_fridge(old_grocs)
      if error
        flash[:notice] = "Fridge update failed :(  "
        flash[:notice] << @user.errors.full_messages.join(". ") << "."
        redirect_to edit_fridge_path and return
      end
    end
    new_grocs = params.delete(:newgrocs)
    new_added=0
    if (new_grocs != nil)
      #byebug
      new_added= @user.update_fridge_new(new_grocs)
    end
    if @user.save  #wont fail until we add validations or force in rspec tests
      flash[:notice] = "Fridge successfully updated!"
      if add 
        add = add.keys[0].to_i
        draw= add-new_added
        redirect_to edit_fridge_path(:additional => "#{draw}")
      else
        redirect_to show_fridge_path
      end
    else
      flash[:notice] = "Fridge update failed :(  "
      flash[:notice] << @user.errors.full_messages.join(". ") << "."
      redirect_to edit_fridge_path
    end
  end
  
end
