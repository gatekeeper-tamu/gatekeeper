class AddPermissionsToSharedSubscription < ActiveRecord::Migration[6.1]
  def change
    add_column :shared_subscriptions, :permission, :integer, :default => 1
  end
end
