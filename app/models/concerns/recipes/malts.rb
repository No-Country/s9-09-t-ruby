module Recipes::Malts
  def total_malt
    has_one_malt? ? ingredient_items.where(addable_type: "Malt").sum(&:quantity) : 0
  end

  def total_sugar_extract
    has_one_malt? ? ingredient_items.where(addable_type: "Malt").sum(&:malt_sugar_extract) : 0
  end

  def mcu_b
    has_one_malt? ? ingredient_items.where(addable_type: "Malt").sum(&:malt_mcu_color) / batch : 0
  end

  def mcu
    has_one_malt? ? ( mcu_b * 2.2 ) / 0.26 : 0
  end

  def srm
    has_one_malt? ? 1.5 * ( mcu ** 0.7 ) : 0
  end
end
