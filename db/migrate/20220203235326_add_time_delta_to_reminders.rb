class AddTimeDeltaToReminders < ActiveRecord::Migration[6.1]
  def change
    add_column :reminders, :time_delta, :datetime
  end
end
