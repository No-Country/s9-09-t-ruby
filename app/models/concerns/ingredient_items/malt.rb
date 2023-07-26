module IngredientItems::Malt
  def malt_sugar_extract
    quantity * addable.extract / 100
  end

  def malt_percentage
    quantity * 100 / recipe.total_malt
  end

  def malt_mcu_color
    quantity * addable.color
  end
end
