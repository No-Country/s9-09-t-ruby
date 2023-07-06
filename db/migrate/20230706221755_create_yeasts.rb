class CreateYeasts < ActiveRecord::Migration[7.0]
  def change
    create_table :yeasts do |t|
      t.string :name
      t.text :description
      t.decimal :dosage, precision: 4, scale: 1
      t.integer :type

      t.timestamps
    end
    add_index :yeasts, :type
  end
end
