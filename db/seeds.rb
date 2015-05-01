Recipe.delete_all

u1 = Unit.create(:unit => 'teaspoon', :conversion_factor => 0.020833)
u2 = Unit.create(:unit => 'tablespoon', :conversion_factor => 0.0625 )
u3 = Unit.create(:unit => 'oz', :conversion_factor => 0.125)
u4 = Unit.create(:unit => 'pint', :conversion_factor => 2)
u5 = Unit.create(:unit => 'gallon', :conversion_factor => 16)
u6 = Unit.create(:unit => 'mL', :conversion_factor => 0.00422675)
u7 = Unit.create(:unit => 'liter', :conversion_factor => 4.22675)
u8 = Unit.create(:unit => 'cup', :conversion_factor => 1)

Food.create!(name: "Peanut Butter")
Food.create!(name: "Dark Chocolate")
Food.create!(name: "Milk")
Food.create!(name: "Honey")
Food.create!(name: "Sugar")
Food.create!(name: "Sommer's Secret Ingredient!!!!!!!!")
Food.create!(name: "whipped cream")
Food.create!(name: "Flour")
Food.create!(name: "Sprinkles")
Food.create!(name: "The Blood of My Enemies...")
Food.create!(name: "BEER")



x = Recipe.new(name: "Dark Chocolate Peanut Butter Cups", cooking_time: 30, directions: "Unwrap and enjoy!", average_rating: 0)
x.ingredients.new(:quantity => 4, :food_id => 1, :unit_id => 5)
x.ingredients.new(:quantity => 2, :food_id => 2, :unit_id => 8)
x.ingredients.new(:quantity => 1, :food_id => 3, :unit_id => 4)
x.save

y = Recipe.new(name: "Reese's cups", cooking_time: 15, directions: "chocolate + peanutbutter == :P", average_rating: 0)
y.ingredients.new(:quantity => 4, :food_id => 1, :unit_id => 7)
y.ingredients.new(:quantity => 2, :food_id => 2, :unit_id => 5)
y.save


u = User.new(:email => 'test@colgate.edu', :password => 'test1234')
u.groceries.new(:quantity => 2, :food_id => 1, :unit_id => 5)
u.groceries.new(:quantity => 4, :food_id => 2, :unit_id => 2)
u.save