class SharedSubscription < ApplicationRecord
  #shared subscription must belong to a subscription and group
  belongs_to :subscription
  belongs_to :group

  #the group must be unique
  validates :group_id, :uniqueness => {:scope=>:subscription_id}

  enum permission: {
    no_access: 0,
    viewer: 1,
    editor: 2
  }
end
