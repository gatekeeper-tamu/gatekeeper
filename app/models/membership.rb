class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :group_id, :uniqueness => {:scope=>:user_id}

  enum permission: {
    viewer: 0,
    collaborator: 1,
    admin: 2
  }
end
