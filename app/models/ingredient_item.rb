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
  include IngredientItems::Malt
  include IngredientItems::Hop
  include IngredientItems::Yeast

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
end
