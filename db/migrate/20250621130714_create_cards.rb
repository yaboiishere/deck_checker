class CreateCards < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      CREATE TYPE card_condition AS ENUM ('mint', 'near_mint', 'excellent', 'good', 'played', 'poor');
    SQL
    create_table :mtg_sets do |t|
      t.string :code
      t.string :name, null: false
    end
    add_index :mtg_sets, :name, unique: true

    create_table :languages do |t|
      t.string :code, null: false
      t.string :name, null: false
    end
    add_index :languages, :code, unique: true
    add_index :languages, :name, unique: true

    create_table :currencies do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.string :symbol, null: false
    end
    add_index :currencies, :code, unique: true
    add_index :currencies, :name, unique: true
    add_index :currencies, :symbol, unique: true

    create_table :cards do |t|
      t.string :name, null: false
      t.string :collector_number, null: false
      t.boolean :foil, null: false
      t.string :rarity, null: false
      t.integer :quantity, null: false
      t.string :scryfall_id
      t.boolean :misprint, null: false, default: false
      t.boolean :altered, null: false, default: false

      t.float :price, null: false, default: 0.0

      t.column :condition, :card_condition, null: false

      t.references :mtg_set, null: false
      t.references :language, null: false
      t.references :currency, null: false


      t.timestamps
    end
    add_index :cards, [ :name,  :mtg_set_id, :collector_number, :language_id, :condition, :foil, :altered, :misprint ], unique: true
  end

  def down
    drop_table :cards
    drop_table :mtg_sets
    drop_table :languages
    drop_table :currencies

    execute <<-SQL
      DROP TYPE card_condition;
    SQL
  end
end
