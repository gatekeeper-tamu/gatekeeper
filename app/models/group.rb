class Group < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  has_many :subscriptions
  has_many :members, class_name: 'Membership'
  has_many :users, through: :members
end
