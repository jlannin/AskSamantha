require 'rails_helper'

RSpec.describe Recipe, type: :model do

  context "the sorted_by method" do
    it "should exist" do
      expect(Recipe).to respond_to(:sorted_by)
    end

    it "should call the right underlying ActiveRecord method to do default sort" do
      expect(Recipe).to receive(:order).with("name") 
      Recipe.sorted_by("name")
    end

    it "should call the right underlying ActiveRecord method to sort by cooking time" do
      expect(Recipe).to receive(:order).with("cooking_time") 
      Recipe.sorted_by("cooking_time")
    end

    it "should handle the situation when a bogus sort column is given" do
      expect(Recipe).to receive(:order).with("name") 
      Recipe.sorted_by("bogus_column")
    end
  end

end
