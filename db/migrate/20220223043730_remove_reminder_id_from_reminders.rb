class RemoveReminderIdFromReminders < ActiveRecord::Migration[6.1]
  def change
    remove_column :reminders, :reminder_id, :integer
  end
end
