class RemoveTimeDeltaFromReminders < ActiveRecord::Migration[6.1]
  def change
    remove_column :reminders, :time_delta, :integer
  end
end
