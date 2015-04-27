class Grocery < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit
  belongs_to :food

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
