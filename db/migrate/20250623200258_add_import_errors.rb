class AddImportErrors < ActiveRecord::Migration[8.0]
  def change
    create_table :import_errors do |t|
      t.references :user, null: false, foreign_key: true
      t.string :file_name, null: false
      t.text :error_message, null: false
    end
  end
end
