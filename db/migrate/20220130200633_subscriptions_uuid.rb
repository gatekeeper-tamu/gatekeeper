class SubscriptionsUuid < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :uuid, :uuid, default: "gen_random_uuid()", null: false

    change_table :subscriptions do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE subscriptions ADD PRIMARY KEY (id);"
  end
end
