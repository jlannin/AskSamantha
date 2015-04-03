Recipe.delete_all

Food.create!(name: "Peanut Butter")
Food.create!(name: "Dark Chocolate")
Food.create!(name: "Milk")
Food.create!(name: "Honey")

x = Recipe.new(name: "Dark Chocolate Peanut Butter Cups", cooking_time: 30, directions: "Unwrap and enjoy!")
x.ingredients.new(:quantity => 4, :food_id => 1)
x.ingredients.new(:quantity => 2, :food_id => 2)
x.ingredients.new(:quantity => 1, :food_id => 3)
x.save

y = Recipe.new(name: "Reese's cups", cooking_time: 15, directions: "chocolate + peanutbutter == :P")
y.ingredients.new(:quantity => 4, :food_id => 1)
y.ingredients.new(:quantity => 2, :food_id => 2)
y.save