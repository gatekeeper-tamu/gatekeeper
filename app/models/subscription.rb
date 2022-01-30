class Subscription < ApplicationRecord
  belongs_to :user
  attr_encrypted :username, key: 'secret'
  attr_encrypted :password, key: 'secret'
end
