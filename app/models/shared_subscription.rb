class SharedSubscription < ApplicationRecord
  belongs_to :subscription
  belongs_to :group

  validates :group_id, :uniqueness => {:scope=>:subscription_id}
end
