class Group < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :user_id

  # sets up tables members (to access membership records) and users (to access the users that belong to the group)
  has_many :members, class_name: 'Membership'
  has_many :users, through: :members

  # sets up tables shared_subscriptions (to access shared_subscriptions records) 
  # and subscriptions (to access the actual subscriptions that have been added to the group)
  has_many :shared_subscriptions, dependent: :destroy
  has_many :subscriptions, through: :shared_subscriptions
  
	validate :owner
end
