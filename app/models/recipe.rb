class Recipe < ActiveRecord::Base
  has_attached_file :image, :styles=> {:medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/empty-plate.jpg"
  validates_attachment :image, :content_type => {:content_type => ["image/jpeg", "image/png", "image/gif"]}
  has_many :ingredients

  def fix_time
    @time = ""
    @mins = self.cooking_time%60
    if self.cooking_time > 60
      @hr = (self.cooking_time/60)
      @time << @hr.to_s
      if @hr == 1
        @time << " hour and "
      else
        @time << " hours and "
      end
    end
    if @mins == 1
      @time << @mins.to_s << " minute"
    else
      @time << @mins.to_s << " minutes"
    end
  end

  def change_ingredients
    ing = ""
    self.ingredients.each do |i|
      ing << i.name << " " << i.quantity.to_s << ","
    end
    ing
  end

  def self.sorted_by(col)
    if self.column_names.include?(col)
      self.order(col)
    else
      self.order("name")
    end
  end

  def self.filter(time)
    if (time == nil || time == "")
      self.all
    else
      self.where("cooking_time <= ?", time)
    end
  end

end
