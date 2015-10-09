class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]


  class << self

    def from_omniauth(auth)
      byebug
      where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
        user.email = auth.info.email
        user.email = "omniauth-#{auth.provider}-#{auth.uid}@facebook.com" unless user.email
        user.password = Devise.friendly_token[0,20]
      end
    end
  end

end
