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

  #owner and group name must exist to be a valid entry
	validates :owner, :group_name, presence: true

  #verify the group is owned by user
  scope :accessible_by_user, ->(user) {
    where(id: user.memberships.pluck(:group_id)).or(where(owner: user))
  }

  def self.where_user_is_collaborator(user)
    #verify group is acessible by user
    accessible_by_user(user).select { |group|
      user.is_collaborator?(group)
    }
  end

  def user_access_level(user)
    #return the permission of user in relation to the group
    return Membership.permissions.key(2) if (user == owner || owner.nil?)
    begin
      membership = members.find_by(user_id: user.id)
      if (membership.nil?)
        return nil
      end
      permission = membership.permission
      return permission
    rescue ActiveRecord::RecordNotFound #if membership does not exist
      return nil
    end
  end
end
