require 'rails_helper'

RSpec.describe RecipesController, type: :controller do

  before :each do
    allow(controller).to receive(:current_user) {nil}
    Food.create!(:name => "Jam")
    Unit.create!(:unit => "cup", :conversion_factor => 10)
    p = Recipe.new(:name => "Dark Chocolate Peanut Butter Cup", :directions => "Unwrap and enjoy!", :cooking_time => 10)
    p.ingredients.new(:quantity => 1, :food_id => 1, :unit_id => 1)
    p.save
  end

  describe "root route" do
    it "routes to recipes#index" do
      expect(:get => '/').to route_to(:controller => "recipes", :action => "index")
    end
  end

  describe "GET #index" do
    it "routes correctly" do
      
      get :index
      expect(response.status).to eq(200)
    end

    it "renders the index template and sorts by name by default" do
      
      y = Recipe.new(:name => "Toast with Jam", :directions => "Put the jam on the toast", :cooking_time => 15)
      y.ingredients.new(:quantity => 2, :food_id => 1) #need at least one ingredient for validation
      y.save
      p = Recipe.find(1)
      expect(Recipe).to receive(:sorted_by).with("name") { [p,y] }
      get :index
      expect(response).to render_template(:index)
      expect(assigns(:recipes)).to match_array([p,y])
    end
  end

  describe "GET #show" do
    it "routes correctly" do
      expect(Recipe).to receive(:find).with("1") { p }
      get :show, id: 1
      p = Recipe.new
      expect(response.status).to eq(200)
    end

    it "renders the show template" do
      expect(Recipe).to receive(:find).with("1") { p }
      get :show, id: 1
      expect(response).to render_template(:show)
    end
  end

describe "POST #create" do
  #####
    it "should show redirect to index on the create good" do
      p = Recipe.new
      Recipe.should_receive(:new).and_return(p)
      p.should_receive(:save).and_return(true)
      post :create, { :recipe => { "name"=>"dummy", "cooking_time"=>"1","directions"=>"test_directs"} }
      response.should redirect_to(recipes_path)
    end


    it "should show redirect to new on the create fail" do
      p = Recipe.new
      Recipe.should_receive(:new).and_return(p)
      p.should_receive(:save).and_return(nil)
      post :create, { :recipe => {"name"=>"tester_Cfail", "cooking_time"=>"1","directions"=>"test_directs"}} 
      response.should redirect_to(new_recipe_path(:additional => 1))
    end
  end

  describe "PUT #update" do
  #####
    it "should show redirect to show on the update good" do
      p = Recipe.find(1)
      expect(p).to receive(:update).and_return(true)
      expect(Recipe).to receive(:find).and_return(p)
      expect(p).to receive(:save).and_return(true)#nil for fail
      put :update, :id => p.id, :recipe => {"name"=>"tester", "cooking_time"=>"1", "directions"=>"test_directs"}, :ingreds => {"ingredient_1"=> "1"}, :dropdown => {"ingredient_1"=>"Jam"}, :units => {"ingredient_1"=>"cup"}
      response.should redirect_to("/recipes/#{p.id}")
    end


    it "should show redirect to edit on the update fail" do
      p = Recipe.find(1)
      expect(p).to receive(:update).and_return(true)
      expect(Recipe).to receive(:find).and_return(p)
      expect(p).to receive(:save).and_return(nil)#nil for fail
      put :update, :id => p.id, :recipe => {"name"=>"tester", "cooking_time"=>"1", "directions"=>"test_directs"}, :ingreds => {"ingredient_1"=> "1"}, :dropdown => {"ingredient_1"=>"Jam"}, :units => {"ingredient_1"=>"cup"}
      response.should redirect_to("/recipes/#{p.id}/edit")
    end

    it "should show redirect to edit (with params additional) on the update fail with no ingredients" do
      p = Recipe.find(1)
      expect(p).to receive(:update).and_return(true)
      expect(Recipe).to receive(:find).and_return(p)
      expect(p).to receive(:save).and_return(nil)#nil for fail
      p.errors[:need_at_least_one_ingredient] = "test"
      put :update, :id => p.id, :recipe => {"name"=>"tester", "cooking_time"=>"1", "directions"=>"test_directs"}, :ingreds => {"ingredient_1"=> "1"}, :dropdown => {"ingredient_1"=>"Jam"}, :units => {"ingredient_1"=>"cup"}
      response.should redirect_to(edit_recipe_path(p.id, :additional => 1))
    end
  end
end

