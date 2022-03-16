class AddSubscriptionBool < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :update_action, :string
  end
end
