module IngredientItems::Hop
  HOP_UTILIZATION_RANGE = {
    "1 - 9" => 6.0,
    "10 - 19" => 15.0,
    "20 - 29" => 19.0,
    "30 - 44" => 24.0,
    "45 - 59" => 27.0,
    "mas de 60" => 34.0
  }
  
  def utilization_percentage
    boil_time == "" ? 34 : HOP_UTILIZATION_RANGE[boil_time]
  end

  def ibus
    ( quantity * utilization_percentage * addable.alpha_acids ) / ( recipe.batch.to_f * 10 * fc )
  end

  def fc
    recipe.computed_og < 1050 ? 1 : ( (( ev.round - 1050 ).to_f / 1000).to_f / 0.2 ) + 1
  end

  def ev
    ( ( (( recipe.computed_og.to_f / 1000 ) - 1) * ( recipe.batch.to_f / (recipe.batch + 4 ) ) ) + 1 ) * 1000
  end

  def hop_percentage
    quantity * 100 / recipe.total_hop
  end
end
