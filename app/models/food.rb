class Food < ActiveRecord::Base
  has_many :ingredients
  has_many :groceries
end
