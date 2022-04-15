class CreateTempSharedSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :temp_shared_subscriptions, id: :uuid do |t|
      t.date :end_date, null: false
      t.references :subscription, null: false, foreign_key: {on_delete: :cascade}, type: :uuid
      t.timestamps
    end
  end
end
