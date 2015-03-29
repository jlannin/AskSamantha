require 'rails_helper'

RSpec.describe "index page", type: :feature do
  before :each do
    Recipe.create!(:name => "Dark Chocolate Peanut Butter Cup", :directions => "Unwrap and enjoy!", :cooking_time => 34)
    Recipe.create!(:name => "Toast with Jam", :description => "Put the jam on the toast", :cooking_time => 12)
    Recipe.find(1).ingredients.create(:name => "Dark Chocolate (Ew)", :quantity => 10)
    Recipe.find(1).ingredients.create(:name => "Peanuts", :quantity => 56)
    Recipe.find(1).ingredients.create(:name => "Butter", :quantity => 10)
    Recipe.find(2).ingredients.create(:name => "Toasted bread", :quantity => 3)
    Recipe.find(2).ingredients.create(:name => "Strawberry Jam", :quantity => 4)

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
    expect(page).to have_content("Dark Chocolate (Ew)")
    expect(page).to have_content("Peanuts")
    expect(page).to have_content("34")
    expect(page).to have_content("56")
    expect(page).to have_content("10")
  end

  it "show link for recipe should show details for the recipe" do
    click_link("Toast with Jam")
    expect(page).to have_link("Back to recipes!")
    expect(page).to have_content("Toast with Jam")
    expect(page).to have_content("Put the jam on the toast")
    expect(page).to have_content("Toasted Bread")
    expect(page).to have_content("Strawberry Jam")
    expect(page).to have_content("12")
    expect(page).to have_content("3")
    expect(page).to have_content("4")
  end

end
