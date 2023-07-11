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
#
class IngredientItem < ApplicationRecord
  belongs_to :addable, polymorphic: true
  belongs_to :recipe

  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :addable_id, uniqueness: { scope: [:recipe_id, :addable_type], message: "ya ha sigo agregado." }

  OPTION_MODEL = {
    "Malt"  => Malt,
    "Hop"   => Hop,
    "Yeast" => Yeast
  }

  def self.set_model(model_name)
    OPTION_MODEL[model_name]
  end

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
