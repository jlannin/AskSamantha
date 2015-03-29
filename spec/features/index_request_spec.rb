require 'rails_helper'

RSpec.describe "index page", type: :feature do
  let(:cooking_time_sort) { ["Leftover Pizza", "Dark Chocolate Peanut Butter Cup", "Toast with Jam", "Cereal" ] }

  before :each do
    Recipe.create!(:name => "Dark Chocolate Peanut Butter Cup", :directions => "Unwrap and enjoy!", :cooking_time => 10)
    Recipe.create!(:name => "Toast with Jam", :directions => "Put the jam on the toast", :cooking_time => 15)
    Recipe.create!(:name => "Leftover Pizza", :directions => "Just pop in the microwave", :cooking_time => 1)
    Recipe.create!(:name => "Cereal", :directions => "Milk first, always", :cooking_time => 20)

    visit "/recipes"
  end

  it "should show the recipes in name order by default" do
    names = []
    page.all(".recipe_name").each { |x| names << x.text}
    expect(names).to match_array(names.sort)
  end

  it "should show the recipes in correct cooking time order when sorting by cooking time" do
    names = []
    click_link("Cooking Time")
    page.all(".recipe_name").each { |x| names << x.text }
    expect(names).to match_array(cooking_time_sort)
  end

  it "should show the recipes in correct name order when sorting by name" do
    names = []
    click_link("Name")
    page.all(".recipe_name").each { |x| names << x.text }
    expect(names).to match_array(names.sort)
  end
end
