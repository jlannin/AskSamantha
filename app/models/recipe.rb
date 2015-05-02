class Recipe < ActiveRecord::Base
  has_attached_file :image, :styles=> {:medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/empty-plate.jpg"
  validates_attachment :image, :content_type => {:content_type => ["image/jpeg", "image/png", "image/gif"]}
  has_many :ingredients
  has_many :reviews
  validates_presence_of :name, :directions, :cooking_time
  validates :cooking_time, :numericality => {:greater_than => 0}
  validate :need_at_least_one_ingredient
  validate :unique_ingredients

  def fix_stars
    @my_stars = ""
    i = self.average_rating.round 
    1.upto(i) {@my_stars<<"★"} #☆⍟🌟✪✰★
    @my_stars #needed?
  end
  
  def fix_miss(miss)
    str = ""
    miss.each do |ing, miss_num|
      
      if miss_num == 1
        str << miss_num.to_s << " " << ing << ", "
      else
        str << miss_num.to_s << " " << ing.pluralize << ", "
      end
    end
    str.slice(0, str.length-2)
  end
  
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

  def update_newingredients(newingreds)
    quantities = newingreds.delete(:new_ingreds)
    names = newingreds.delete(:new_dropdown)
    units = newingreds.delete(:new_units)
    count = 0
    if(quantities != nil)
      quantities.each do |ing|
        if(ing[1].to_i > 0)
          count = count + 1
          self.ingredients.new(:quantity => ing[1].to_i, :food_id => "#{Food.find_by('name = ?', names[ing[0].to_sym].to_s).id}", :unit_id => "#{Unit.find_by('unit = ?', units[ing[0].to_sym].to_s).id}")
        end
      end
    end
    count
  end

  def update_ingredients(old)
    quantities = old.delete(:ingreds)
    names = old.delete(:dropdown)
    units = old.delete(:units)
    if(quantities != nil)
      quantities.each do |ing|
        ing[0] =~ /^ingredient_(\d+)/
        if (ing[1].to_i > 0)
          Ingredient.find($1).update(:quantity => "#{ing[1]}", :food_id => "#{Food.find_by('name = ?', names[ing[0].to_sym].to_s).id}", :unit_id => "#{Unit.find_by('unit = ?', units[ing[0].to_sym].to_s).id}")
        else#quant is a bad number
          Ingredient.find($1).destroy #HIT THIS
        end
      end
    end
  end

  def self.search(search)
    Recipe.where("name like ?", "%#{search}%")
  end

  def self.sorted_by(col)
    if self.column_names.include?(col)
      if col == "average_rating"
        s = self.order("#{col} DESC")
      else
        s = self.order(col)
      end
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

  def update_avg_rating(new_rating)
    if (new_rating != nil)
      count = self.reviews.length + 1
      rating = new_rating
      self.reviews.each do |r|
        rating += r.stars
      end
      self.average_rating = rating.to_f / count.to_f
    end
  end

  def cook_helper(user)
    missing_ingred = Hash.new()
    my_groceries = grocery_list(user) # { Food Name : Grocery Quantity }
    Ingredient.where('recipe_id = ?', self.id).each do |ingred|
        if (my_groceries[ingred.food.name] == nil)
            missing_ingred[ingred.food.name] = ingred.quantity
        elsif (my_groceries[ingred.food.name] < ingred.quantity)
            f = Food.find_by("name = ?","#{ingred.food.name}")
            g = Grocery.where('user_id = ?', user.id).find_by("food_id = ?", f.id)
            User.delete_grocery(g)
        elsif (my_groceries[ingred.food.name] == ingred.quantity)
            
            f = Food.find_by("name = ?", "#{ingred.food.name}")
            g = Grocery.where("user_id = ?", user.id).find_by("food_id = ?", f.id)
            User.delete_grocery(g)
        else
            f = Food.find_by("name = ?", "#{ingred.food.name}")
	    g = Grocery.where('user_id = ?', user.id).find_by("food_id = ?", f.id)
	    g.update(:quantity => "#{(g.quantity - ingred.quantity)}")
        end
    end
  end

  def self.sort_cook(cookable)
    zero = []
    one = []
    two = []
    cookable.each do |k, v|
      if(v.length == 0)
        zero << {k => v}
      end
      if(v.length == 1)
        one << {k => v}
      end
      if(v.length == 2)
        two << {k => v}
      end
    end
    zero.concat(one).concat(two)
  end

def lacking(user)
## this method takes a recipe and a user and creates a hash with the food lacking in a fridge to make a recipe
    lacking = Hash.new()
    my_groceries = grocery_list(user) # returns hash of {Food name : Grocery quantity}
    self.ingredients.each do |ingred|
        if (my_groceries[ingred.food.name] == nil)
            lacking[ingred.food.name] = ingred.quantity
        elsif (my_groceries[ingred.food.name] < ingred.quantity)
            lacking[ingred.food.name] = (ingred.quantity - my_groceries[ingred.food.name])
        end
    end
    lacking
end

def grocery_list(user)
## given a user, this method creates a hash list of groceries in a user's fridge
## { Food Name : Grocery Quantity }
    my_groceries = Hash.new()
    user.groceries.each do |grocery|
        my_groceries[grocery.food.name] = grocery.quantity
    end
    return my_groceries
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
