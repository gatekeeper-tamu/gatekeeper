class ReminderUuid < ActiveRecord::Migration[6.1]
  def change
    add_column :reminders, :uuid, :uuid, default: "gen_random_uuid()", null: false

    change_table :reminders do |t|
      t.remove :id
      t.remove :subscription_id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE reminders ADD PRIMARY KEY (id);"
  end
end
