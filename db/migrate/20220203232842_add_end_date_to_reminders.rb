class AddEndDateToReminders < ActiveRecord::Migration[6.1]
  def change
    add_column :reminders, :end_date, :datetime
  end
end
