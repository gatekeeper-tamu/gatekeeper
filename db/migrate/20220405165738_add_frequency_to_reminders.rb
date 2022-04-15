class AddFrequencyToReminders < ActiveRecord::Migration[6.1]
  def change
    add_column :reminders, :frequency, :string
    rename_column :reminders, :time_delta, :notification_time
  end
end