class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups, id: :uuid do |t|
      t.string :group_name
      t.references :user, null: false, foreign_key: {on_delete: :cascade}, type: :uuid

      t.timestamps
    end
  end
end
