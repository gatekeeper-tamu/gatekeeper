class CreateSharedSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :shared_subscriptions, id: :uuid do |t|
      t.references :subscription, null: false, foreign_key: {on_delete: :cascade}, type: :uuid
      t.references :group, null: false, foreign_key: {on_delete: :cascade}, type: :uuid

      t.timestamps
    end
  end
end
