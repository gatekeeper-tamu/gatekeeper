class Subscription < ApplicationRecord
	has_kms_key
	
  belongs_to :user
  has_many :share_records, class_name: 'SharedSubscription', :dependent => :delete_all 
  has_many :groups, through: :share_records

  # attr_encrypted_options.merge!(encryptor: SubscriptionEncryptor, encrypt_method: :encrypt, decrypt_method: :decrypt)
  attr_encrypted :username, key: Rails.env.test? ? '2K31QRnurJBWvtWkTE3uXfKA7vivrvA5' : :kms_key
  attr_encrypted :password, key: Rails.env.test? ? '2K31QRnurJBWvtWkTE3uXfKA7vivrvA5' : :kms_key

  def redacted_password
    "*" * password.length
  end

end
