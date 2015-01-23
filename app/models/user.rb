class User < ActiveRecord::Base
	has_many :tweets
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
				 
	devise :omniauthable, :omniauth_providers => [:twitter]

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.email = "#{auth.info.nickname}@twitter.com"
			user.password = Devise.friendly_token[0,20]
			user.username = auth.info.nickname #assuming the user model has a name
		end
	end
	
end

