class CreateInventoryItems < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_items do |t|
      t.integer :available
      t.references :inventoriable, polymorphic: true

      t.timestamps
    end
  end
end
