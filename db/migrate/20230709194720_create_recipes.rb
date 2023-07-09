class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.text :description
      t.string :style, null: false
      t.decimal :batch, precision: 6, scale: 1, null: false
      t.decimal :og, precision: 5, scale: 1
      t.decimal :fg, precision: 5, scale: 1
      t.decimal :abv, precision: 3, scale: 1
      t.decimal :color, precision: 4, scale: 1
      t.decimal :ibus, precision: 4, scale: 1

      t.timestamps
    end
  end
end
