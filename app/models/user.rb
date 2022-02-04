class User < ApplicationRecord
	class << self
		attr_accessor :email
		attr_accessor :username
		attr_accessor :password
		attr_accessor :first_name
		attr_accessor :last_name
		attr_accessor :image_url
	end

	devise :omniauthable, omniauth_providers: %i[google_oauth2]
	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			puts auth
			user.email = auth.info.email
			user.username = user.email.split("@").first
			user.password = Devise.friendly_token[0, 20]
			user.first_name = auth.info.first_name   # assuming the user model has a name
			user.last_name = auth.info.last_name
			user.image_url = auth.info.image # assuming the user model has an image
			# If you are using confirmable and the provider(s) you use validate emails,
			# uncomment the line below to skip the confirmation emails.
			# user.skip_confirmation!
		end
	end
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
			:recoverable, :rememberable, :validatable,
			:timeoutable, :omniauthable
	validates_uniqueness_of :username
	
	has_many :subscriptions
end
