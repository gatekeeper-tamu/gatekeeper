class SharedSubscription < ApplicationRecord
  belongs_to :subscription
  belongs_to :group
end
