require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before :each do
    allow(controller).to receive(:current_user) {nil}
    Food.create!(:name => "Jam")
    Unit.create!(:unit => "cup", :conversion_factor => 10)
    u = User.new(:email => "test@colgate.edu", :password => "test1234")
    u.groceries.new(:quantity => 2, :food_id => 1, :unit_id => 1)
    u.save
    p = Recipe.new(:name => "Dark Chocolate Peanut Butter Cup", :directions => "Unwrap and enjoy!", :cooking_time => 10, average_rating: 0)
    p.ingredients.new(:quantity => 1, :food_id => 1, :unit_id => 1)
    p.save
  end


  describe "PUT #update" do
    it "should redirect to fridge on update good" do
      us = User.find(1)
      expect(controller).to receive(:current_user) {us}
      expect(us).to receive(:save).and_return(true)#nil for fail
      put :update, :oldgroc => {"grocs" => {"grocery_1"=> "1"}, "dropdown" => {"grocery_1"=>"Jam"}, "units" => {"grocery_1"=>"cup"}}
      response.should redirect_to("/fridge")
    end

    it "should redirect to edit fridge on update fail" do
      us = User.find(1)
      expect(controller).to receive(:current_user) {us}
      expect(us).to receive(:save).and_return(false)#nil for fail
      put :update, :oldgroc => {"grocs" => {"grocery_1"=> "1"}, "dropdown" => {"grocery_1"=>"Jam"}, "units" => {"grocery_1"=>"cup"}}
      response.should redirect_to("/fridge/edit")
    end
  end
end
