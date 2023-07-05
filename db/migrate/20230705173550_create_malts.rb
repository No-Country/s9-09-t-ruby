class CreateMalts < ActiveRecord::Migration[7.0]
  def change
    create_table :malts do |t|
      t.string :name
      t.text :description
      t.decimal :extract, precision: 3, scale: 1
      t.decimal :color, precision: 4, scale: 1
      t.decimal :ph, precision: 2, scale: 1

      t.timestamps
    end
  end
end
