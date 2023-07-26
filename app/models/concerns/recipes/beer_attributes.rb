module Recipes::BeerAttributes
  def real_extract
    has_one_malt? ? total_sugar_extract * (general_configuration.efficiency_extract/100) : 0
  end

  def pre_boil_density
  end

  def computed_og
    has_one_yeast? ? 1000 + ( ( 4 * (real_extract * 1000) ) / ( 10 * batch ) ).round : 0
  end

  def computed_fg
    has_one_yeast? ? ( ( computed_og - 1000 ) - ( ( computed_og - 1000 ) * ( ingredient_items.where(addable_type: "Yeast").first.addable.attenuation.to_f / 100) ) + 1000 ).round : 0
  end

  def computed_abv
    ( computed_og - computed_fg ) / 7.5
  end
end
