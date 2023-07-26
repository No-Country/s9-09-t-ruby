module Recipes::IngredientQuantities
  def ingredient_items_quantities(batch)
    quantities = {
      "malts" => {},
      "hops" => {},
      "yeast" => {},
      "mash_water" => 0
    }
    # Add quantities from malts ingredients
    ingredient_items.where(addable_type: "Malt").each do |malt|
      quantity = malt_ingredient_quantity(malt.malt_percentage, malt.addable.extract, batch).round(2)
      quantities["malts"].store(malt.addable.name, quantity)
      quantities["mash_water"] += (quantity * mash.water_grain_ratio)
    end
    # Add quantities from hops ingredients
    ingredient_items.where(addable_type: "Hop").each do |hop|
      quantities["hops"].store(hop.addable.name, {
        "quantity" => hop_ingredient_quantity(hop.ibus, hop.fc, hop.utilization_percentage, hop.addable.alpha_acids, batch).round(2),
        "boil_time" => hop.boil_time
        })
    end
    # Add dosage from yeast ingredient
    ingredient_items.where(addable_type: "Yeast").each do |yeast|
      quantities["yeast"].store(yeast.addable.name, yeast_ingredient_quantity(yeast.addable.dosage, batch).round(2))
    end
    quantities
  end

  def lot_sugar_extract(batch)
    # In Kg
    (( (og - 1000) * 10 * batch ) / 4) / 1000
  end

  def malt_ingredient_quantity(malt_percentage, malt_extract, batch)
    ( lot_sugar_extract(batch) * (malt_percentage / 100) ) / ( (malt_extract / 100) * (general_configuration.efficiency_extract / 100) )
  end

  # Hops
  def hop_ingredient_quantity(ibus, fc, utilization_percentage, alpha_acids, batch)
    # In grams
    ( ibus * batch * 10 * fc ) / ( utilization_percentage * alpha_acids )
  end

  # Yeast
  def yeast_ingredient_quantity(dosage, batch)
    ( dosage * batch ) / 100
  end
end
