class Subscription < ApplicationRecord
	has_kms_key
	
  belongs_to :user

  # attr_encrypted_options.merge!(encryptor: SubscriptionEncryptor, encrypt_method: :encrypt, decrypt_method: :decrypt)
  attr_encrypted :username, key: :kms_key
  attr_encrypted :password, key: :kms_key

  def redacted_password
    "*" * password.length
  end

end
