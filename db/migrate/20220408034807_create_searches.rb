class CreateSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :searches, id: :uuid do |t|
      t.integer :search_id
      t.string :title

      t.timestamps
    end
  end
end
