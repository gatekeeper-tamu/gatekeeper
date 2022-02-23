class RemoveSubscriptionIdFromReminders < ActiveRecord::Migration[6.1]
  def change
    remove_column :reminders, :subscription_id, :integer
  end
end
