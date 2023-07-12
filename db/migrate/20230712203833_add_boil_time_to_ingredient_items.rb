class AddBoilTimeToIngredientItems < ActiveRecord::Migration[7.0]
  def change
    add_column :ingredient_items, :boil_time, :string
  end
end
