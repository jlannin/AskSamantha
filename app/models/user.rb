class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
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

end
