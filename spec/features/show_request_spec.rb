require 'rails_helper'

RSpec.describe "show page", type: :feature do
  before :each do
    Recipe.create!(:name => "Dark Chocolate Peanut Butter Cup", :directions => "Unwrap and enjoy!", :cooking_time => 34)
    Recipe.create!(:name => "Toast with Jam", :directions => "Put the jam on the toast", :cooking_time => 12)
    Food.create!(:name => "Dark Chocolate")
    Food.create!(:name => "Peanut Butter")
    Food.create!(:name => "Jam")
    Ingredient.create!(:quantity => 56, :food_id => 1, :recipe_id => 1)  #56 dark chocolates to dark chocolate peanut butter cup
    Ingredient.create!(:quantity => 10, :food_id => 2, :recipe_id => 1)  #10 Peanut butters to dark chocolate cup
    Ingredient.create!(:quantity => 23, :food_id => 3, :recipe_id => 2)   #Toast gets 23 Jams
    Ingredient.create!(:quantity => 6, :food_id => 2, :recipe_id => 2)   #Toast gets 6 Peanuts Buttre


    visit "/recipes"
  end

  it "should have links from each recipe name to 'show' pages" do
    expect(page).to have_link("Dark Chocolate Peanut Butter Cup")
    expect(page).to have_link("Toast with Jam")
  end

  it "show link for recipe should show details for the recipe" do
    click_link("Dark Chocolate Peanut Butter Cup")
    expect(page).to have_link("Back to recipes!")
    expect(page).to have_content("Dark Chocolate Peanut Butter Cup")
    expect(page).to have_content("Unwrap and enjoy!")
    expect(page).to have_content("Dark Chocolate")
    expect(page).to have_content("Peanut Butter")
    expect(page).to have_content("34")
    expect(page).to have_content("56")
    expect(page).to have_content("10")
  end

  it "show link for recipe should show details for the recipe" do
    click_link("Toast with Jam")
    expect(page).to have_link("Back to recipes!")
    expect(page).to have_content("Toast with Jam")
    expect(page).to have_content("Put the jam on the toast")
    expect(page).to have_content("Jam")
    expect(page).to have_content("Peanut Butter")
    expect(page).to have_content("12")
    expect(page).to have_content("23")
    expect(page).to have_content("6")
  end

end
