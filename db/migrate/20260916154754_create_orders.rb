class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: true, foreign_key: true
      t.string :full_name, null: false
      t.string :email, null: false
      t.string :delivery_address, null: false
      t.string :payment_method, null: false, default: "cash_on_delivery"
      t.decimal :total_price, precision: 10, scale: 2, null: false, default: 0.0
      t.integer :status, null: false, default: 0
      t.text :notes

      t.timestamps
    end
  end
end