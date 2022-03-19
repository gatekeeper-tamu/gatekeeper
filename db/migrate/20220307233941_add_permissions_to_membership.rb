class AddPermissionsToMembership < ActiveRecord::Migration[6.1]
  def change
    add_column :memberships, :permission, :integer, :default => 0
  end
end
