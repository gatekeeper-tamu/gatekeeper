class CreateNetworks < ActiveRecord::Migration[6.1]
  def change
    create_table :networks, id: :uuid do |t|
      t.integer :search_id
      t.string :network_name
      t.string :network_url

      t.timestamps
    end
  end
end
