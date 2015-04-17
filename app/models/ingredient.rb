class Ingredient < ActiveRecord::Base
belongs_to :recipe
belongs_to :food
belongs_to :unit
end
