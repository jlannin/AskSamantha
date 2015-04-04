class Recipe < ActiveRecord::Base
  has_attached_file :image, :styles=> {:medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/empty-plate.jpg"
  validates_attachment :image, :content_type => {:content_type => ["image/jpeg", "image/png", "image/gif"]}
  has_many :ingredients
  validates_presence_of :name, :directions, :cooking_time
  validates :cooking_time, :numericality => {:greater_than => 0}
  validate :need_at_least_one_ingredient
  validate :unique_ingredients


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

  def update_newingredients(quantities, names)
    if(quantities != nil)
      quantities.each do |ing|
        if(ing[1].to_i > 0)
          self.ingredients.new(:quantity => ing[1].to_i, :food_id => "#{Food.find_by('name = ?', names[ing[0].to_sym].to_s).id}")
        end
      end
    end
  end

  def update_ingredients(quantities, names)
    if(quantities != nil)
      quantities.each do |ing|
        #byebug
        ing[0] =~ /^ingredient_(\d+)/
        if (ing[1].to_i > 0)
          Ingredient.find($1).update(:quantity => "#{ing[1]}", :food_id => "#{Food.find_by('name = ?', names[ing[0].to_sym].to_s).id}")
        else#quant is a bad number
          Ingredient.find($1).destroy #HIT THIS
        end
      end
    end
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

  private

  def need_at_least_one_ingredient
    if self.ingredients.length == 0
      errors[:need_at_least_one_ingredient] << "when saving recipe"
    end
  end

  def unique_ingredients
    ing_arr = self.ingredients.map do |x|
      x.food.name
    end
    if (ing_arr != ing_arr.uniq)
      errors[:unique_ingredients] << "are needed"
    end
  end
      

end
