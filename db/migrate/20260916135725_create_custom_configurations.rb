class CreateCustomConfigurations < ActiveRecord::Migration[7.0]
  def change
    create_table :custom_configurations do |t|
      t.string :product_type, null: false, default: "window"
      t.integer :width, null: false
      t.integer :height, null: false
      t.string :profile_system, null: false
      t.string :glass_type, null: false
      t.string :hardware, null: false
      t.boolean :with_installation, default: false, null: false
      t.decimal :calculated_price, precision: 10, scale: 2, null: false, default: 0.0
      t.jsonb :configuration_data

      t.timestamps
    end
  end
end