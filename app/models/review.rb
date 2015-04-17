class Review < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user
  validates_presence_of :comments

   def show_stars
    @my_stars = ""
    i = self.stars 
    1.upto(i) {@my_stars<<"★"} #☆⍟🌟✪✰★
    @my_stars 
  end

end
