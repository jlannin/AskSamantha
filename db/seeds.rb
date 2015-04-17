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

u1 = Unit.create(:unit => 'teaspoon', :conversion_factor => 0.020833)
u2 = Unit.create(:unit => 'tablespoon', :conversion_factor => 0.0625 )
u3 = Unit.create(:unit => 'oz', :conversion_factor => 0.125)
u4 = Unit.create(:unit => 'pint', :conversion_factor => 2)
u5 = Unit.create(:unit => 'gallon', :conversion_factor => 16)
u6 = Unit.create(:unit => 'mL', :conversion_factor => 0.00422675)
u7 = Unit.create(:unit => 'liter', :conversion_factor => 4.22675)
u8 = Unit.create(:unit => 'cups', :conversion_factor => 1)























