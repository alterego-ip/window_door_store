class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name, null: false
      t.string :sku, null: false, index: { unique: true }
      t.decimal :price, precision: 10, scale: 2, null: false, default: 0.0
      t.integer :stock, null: false, default: 0
      t.text :description
      t.jsonb :metadata

      t.timestamps
    end
  end
end