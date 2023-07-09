class CreateIngredientItems < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredient_items do |t|
      t.decimal :quantity, precision: 5, scale: 1
      t.references :addable, polymorphic: true

      t.timestamps
    end
  end
end
