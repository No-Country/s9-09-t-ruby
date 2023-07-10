class AddRecipeReferencesToIngredientItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :ingredient_items, :recipe, null: false, foreign_key: true
  end
end
