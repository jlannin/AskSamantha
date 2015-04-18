class Ingredient < ActiveRecord::Base
belongs_to :recipe
belongs_to :food
belongs_to :unit

  def format_quantity
    q = ""
    q << self.quantity.to_s << " " << self.unit.unit
    if self.quantity > 1
      q << "s"
    else
      q
    end
  end


end
