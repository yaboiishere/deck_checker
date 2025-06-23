class AddCollections < ActiveRecord::Migration[8.0]
  def change
    create_table :collections do |t|
      t.references :user, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true
      t.integer :quantity, null: false
    end

    add_index :collections, [ :user_id, :card_id ], unique: true

    remove_column :cards, :quantity, :integer
  end
end
