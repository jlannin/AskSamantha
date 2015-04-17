require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  before :each do
    #expect(controller).to receive(:current_user) {nil}
    u=User.create!(:email => "test@gmail.com", :password=> "test1234")
    expect(request.env['warden']).to receive(:authenticate!) {u}
    expect(controller).to receive(:current_user) {u}
    Food.create!(:name => "Test")
    x = Recipe.new(:name => "Dark Chocolate Peanut Butter Cup", :directions => "Unwrap and enjoy!", :cooking_time => 10)
    x.ingredients.new(:quantity => 1, :food_id => 1) 
    x.save
  end

  describe "POST #create" do
    it "should show redirect to show on the create good for review" do
      rec = Recipe.find(1)
      r = Review.new
      expect(Recipe).to receive(:find).with("1") { rec }
      Review.should_receive(:new).and_return(r)
      rec.should_receive(:save).and_return(true)
      post :create, { :review => { "stars"=>"3", "comments"=>"Good"}, :recipe_id => "1" }
      response.should redirect_to(recipe_path(rec))
    end

    it "should show redirect to create review page on the create fail for reviews" do
      rec = Recipe.find(1)
      r = Review.new
      expect(Recipe).to receive(:find).with("1") { rec }
      Review.should_receive(:new).and_return(r)
      rec.should_receive(:save).and_return(false)
      post :create, { :review => { "stars"=>"3", "comments"=>"Good"}, :recipe_id => "1" }
      response.should redirect_to(new_recipe_review_path)
    end
  end
end


