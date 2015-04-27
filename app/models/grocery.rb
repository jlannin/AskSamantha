class Grocery < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit
  belongs_to :food
end
