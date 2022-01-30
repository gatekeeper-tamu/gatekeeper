class Subscription < ApplicationRecord
  belongs_to :user
  usernamekey = Base64.encode64(SecureRandom.random_bytes(32))
  passkey = Base64.encode64(SecureRandom.random_bytes(32))
  attr_encrypted :username, key: Base64.decode64(usernamekey), insecure_mode: true
  attr_encrypted :password, key: Base64.decode64(passkey), insecure_mode: true
end
