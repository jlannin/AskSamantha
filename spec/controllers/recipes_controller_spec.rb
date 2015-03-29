require 'rails_helper'

RSpec.describe RecipesController, type: :controller do

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
      x, y = Recipe.create!, Recipe.create!
      expect(Recipe).to receive(:sorted_by).with("name") { [x,y] }
      get :index
      expect(response).to render_template(:index)
      expect(assigns(:recipes)).to match_array([x,y])
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
end
