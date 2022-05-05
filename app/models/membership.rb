class Membership < ApplicationRecord
  #membership must belong to a user and group
  belongs_to :user
  belongs_to :group

  #the group association must be unique
  validates :group_id, :uniqueness => {:scope=>:user_id}

  enum permission: {
    viewer: 0,
    collaborator: 1,
    admin: 2
  }
end
