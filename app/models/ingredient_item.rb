# == Schema Information
#
# Table name: ingredient_items
#
#  id           :bigint           not null, primary key
#  quantity     :decimal(5, 1)
#  addable_type :string
#  addable_id   :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipe_id    :bigint           not null
#  boil_time    :string
#
class IngredientItem < ApplicationRecord
  belongs_to :addable, polymorphic: true
  belongs_to :recipe

  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :addable_id, uniqueness: { scope: [:recipe_id, :addable_type], message: "ya ha sigo agregado." }
  # validates_with IngredientItems::YeastDossage, if: :is_yeast_ingredient
  validate :recommended_yeast_quantity, if: :is_yeast_ingredient

  OPTION_MODEL = {
    "Malt"  => Malt,
    "Hop"   => Hop,
    "Yeast" => Yeast
  }

  HOP_UTILIZATION_RANGE = {
    "1 - 9" => 6,
    "10 - 19" => 15,
    "20 - 29" => 19,
    "30 - 44" => 24,
    "45 - 59" => 27,
    "mas de 60" => 34
  }

  def self.boil_time_range
    HOP_UTILIZATION_RANGE
  end

  def self.set_model(model_name)
    OPTION_MODEL[model_name]
  end

  def recommended_yeast_quantity
    return if addable == nil
    return if quantity == nil
    recommended_dosage = ( addable.dosage * recipe.batch ) / 100
    if quantity < recommended_dosage
      errors.add(:quantity, "Debe ser mayor a #{recommended_dosage}")
    end
  end

  def is_yeast_ingredient
    addable_type == "Yeast"
  end

  # Matls
  def malt_sugar_extract
    quantity * addable.extract / 100
  end

  def malt_percentage
    quantity * 100 / recipe.total_malt
  end

  def malt_mcu_color
    quantity * addable.color
  end

  # Hops

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
