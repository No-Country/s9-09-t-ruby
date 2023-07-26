module Recipes::Hops
  def total_hop
    has_one_hop? ? ingredient_items.where(addable_type: "Hop").sum(&:quantity) : 0
  end

  def total_ibus
    has_one_hop? ? ingredient_items.where(addable_type: "Hop").sum(&:ibus) : 0
  end
end
