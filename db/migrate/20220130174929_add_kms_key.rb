class AddKmsKey < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :encrypted_kms_key, :text
  end
end
