class CreateReminders < ActiveRecord::Migration[6.1]
  def change
    create_table :reminders, id: :uuid do |t|
      t.boolean :recurring, null: false
      t.string :reminder_type, null: false
      t.integer :time_delta, null: false
      t.date :end_date, null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end
  end
end


