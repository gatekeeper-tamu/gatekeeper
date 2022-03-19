class SharedSubscription < ApplicationRecord
  belongs_to :subscription
  belongs_to :group

  validates :group_id, :uniqueness => {:scope=>:subscription_id}

  enum permission: {
    no_access: 0,
    viewer: 1,
    editor: 2
  }
end
