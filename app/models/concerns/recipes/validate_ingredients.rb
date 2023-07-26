module Recipes::ValidateIngredients
  def has_one_malt?
    ingredient_items.where(addable_type: "Malt").count > 0
  end

  def has_one_hop?
    ingredient_items.where(addable_type: "Hop").count > 0
  end

  def has_one_yeast?
    ingredient_items.where(addable_type: "Yeast").count > 0
  end

  def has_a_mash?
    !mash.nil?
  end

  def has_ingredients_and_mashing?
    has_one_malt? and has_one_hop? and has_one_yeast? and has_a_mash?
  end
end
