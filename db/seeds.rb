Recipe.delete_all

Food.create!(name: "Peanut Butter")
Food.create!(name: "Dark Chocolate")
Food.create!(name: "Milk")
Food.create!(name: "Honey")

Recipe.create!(name: "Dark Chocolate Peanut Butter Cups", cooking_time: 30)
Ingredient.create!(:quantity => 4, :recipe_id => 1, :food_id => 1)
Ingredient.create!(:quantity => 2, :recipe_id => 1, :food_id => 2)
Ingredient.create!(:quantity => 1, :recipe_id => 1, :food_id => 3)
