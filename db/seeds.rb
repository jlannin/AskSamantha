# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Recipe.delete_all

Recipe.create!(name: "Dark Chocolate Peanut Butter Cups", cooking_time: 30)

Recipe.create!(name: "Buffalo Tenders", directions: "First find a buffalo", cooking_time: 10)
Recipe.create!(name: "Cereal", directions: "Milk then cereal", cooking_time: 5)
Recipe.create!(name: "Toast", directions: "Bread into toaster", cooking_time: 3)
Recipe.create!(name: "Toast with Jam", directions: "Put the jam on the toast", cooking_time: 43)
Recipe.find(5).ingredients.create(:name => "Toast", :quantity => 1)
Recipe.find(5).ingredients.create(:name => "Jam", :quantity => 1)
Recipe.find(1).ingredients.create(:name => "Dark Chocolate (Ew)", :quantity => 10)
Recipe.find(1).ingredients.create(:name => "Peanuts", :quantity => 10)
Recipe.find(1).ingredients.create(:name => "Butter", :quantity => 10)