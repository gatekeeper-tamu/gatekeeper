class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :encrypted_username
      t.string :encrypted_username_iv
      t.string :encrypted_password
      t.string :encrypted_password_iv
      t.string :url
      t.float :cost_per_month
      t.string :image

      t.timestamps
    end
  end
end
