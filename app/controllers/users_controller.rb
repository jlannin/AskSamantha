class UsersController < ApplicationController

  def show_fridge
    @groceries = @user.groceries
  end
end
