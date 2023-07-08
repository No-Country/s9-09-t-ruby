class CreateInventoryMovements < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_movements do |t|
      t.integer :quantity, null: false
      t.integer :movement_type, null: false
      t.references :inventory_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
