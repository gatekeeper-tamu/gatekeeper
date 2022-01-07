class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.string :category
      t.datetime :end_date
      t.string :sub_username
      t.string :sub_password
      t.float :monthly_cost
      t.string :owner_id

      t.timestamps
    end
  end
end
