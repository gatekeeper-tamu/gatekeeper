class CreateReminders < ActiveRecord::Migration[6.1]
  def change
    create_table :reminders do |t|
      t.integer :subscription_id
      t.integer :reminder_id
      t.integer :time_delta
      t.boolean :recurring
      t.string :message
      t.timestamps
    end
  end
end
