class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :product, null: true, foreign_key: true
      t.references :custom_configuration, null: true, foreign_key: true
      t.integer :quantity, default: 1, null: false
      t.decimal :unit_price, precision: 10, scale: 2, null: false, default: 0.0

      t.timestamps
    end
  end
end