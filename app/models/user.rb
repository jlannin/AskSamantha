class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :reviews
  has_many :groceries
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:github]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.user_name = auth.info.user_name # assuming the user model has a name
      user.password = Devise.friendly_token[0,20]
    end
  end

  def get_name
    email = self.email
    email =~ /^(.+)@/
    $1
  end

  def update_fridge(oldgrocs)
    quantities = oldgrocs.delete(:groc)
    names = oldgrocs.delete(:dropdown)
    units = oldgrocs.delete(:units)
    if(quantities != nil)
      quantities.each do |g|
        g[0] =~ /^grocery_(\d+)/
        if (g[1].to_i > 0)
          Grocery.find($1).update(:quantity => "#{g[1]}", :food_id => "#{Food.find_by('name = ?', names[g[0].to_sym].to_s).id}", :unit_id => "#{Unit.find_by('unit = ?', units[g[0].to_sym].to_s).id}")
        else#quant is a bad number
          Grocery.find($1).destroy #HIT THIS
        end
      end
    end
  end

  def update_fridge_new(newgrocs)
    quantities = newgrocs.delete(:new_grocs)
    names = newgrocs.delete(:new_dropdown)
    units = newgrocs.delete(:new_units)
    count = 0
    if(quantities != nil)
      quantities.each do |g|
        if(g[1].to_i > 0)
          self.groceries.new(:quantity => g[1].to_i, :food_id => "#{Food.find_by('name = ?', names[g[0].to_sym].to_s).id}", :unit_id => "#{Unit.find_by('unit = ?', units[g[0].to_sym].to_s).id}")
          count = count +1
        end
      end
    end
    count
  end
end
