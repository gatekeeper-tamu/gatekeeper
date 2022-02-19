class Group < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :user_id

  # sets up tables members (to access membership records) and users (to access the users that belong to the group)
  has_many :members, class_name: 'Membership', dependent: :destroy
  has_many :users, through: :members
  accepts_nested_attributes_for :members, allow_destroy: true

  # sets up tables shared_subscriptions (to access shared_subscriptions records) 
  # and subscriptions (to access the actual subscriptions that have been added to the group)
  has_many :shared_subscriptions, dependent: :destroy
  has_many :subscriptions, through: :shared_subscriptions
  accepts_nested_attributes_for :shared_subscriptions, allow_destroy: true
  
	validate :owner
end
