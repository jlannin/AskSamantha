# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Recipe.delete_all

Recipe.create!(name: "Dark Chocolate Peanut Butter Cups", cooking_time: 30)
Recipe.create!(name: "Buffalo Tenders", cooking_time: 10)
Recipe.create!(name: "Cereal", cooking_time: 5)
Recipe.create!(name: "Toast", cooking_time: 3)
Recipe.create!(name: "Toast with Jam", cooking_time: 43)