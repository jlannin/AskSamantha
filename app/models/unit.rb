class Unit < ActiveRecord::Base
  has_many :ingredients
  has_many :groceries

#  def convert_fact(in_unit, out_unit)
    
#  end

end
