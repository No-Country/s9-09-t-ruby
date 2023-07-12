# == Schema Information
#
# Table name: recipes
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :text
#  style       :string           not null
#  batch       :decimal(6, 1)    not null
#  og          :decimal(5, 1)
#  fg          :decimal(5, 1)
#  abv         :decimal(3, 1)
#  color       :decimal(4, 1)
#  ibus        :decimal(4, 1)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Recipe < ApplicationRecord
  validates :name, :description, :style, :batch, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :batch, numericality: { greater_than: 0 }

  has_many :ingredient_items, dependent: :destroy

  scope :ordered, -> { order(id: :desc) }


  def real_extract
    total_sugar_extract * 0.7
  end

  def computed_og
    1000 + ( ( 4 * (real_extract * 1000) ) / ( 10 * batch ) ).round
  end

  def computed_fg
    ( ( computed_og - 1000 ) - ( ( computed_og - 1000 ) * ( ingredient_items.where(addable_type: "Yeast").first.addable.attenuation.to_f / 100) ) + 1000 ).round
  end

  def computed_abv
    ( computed_og - computed_fg ) / 7.5
  end

  # Malts
  def total_malt
    ingredient_items.where(addable_type: "Malt").sum(&:quantity)
  end

  def total_sugar_extract
    ingredient_items.where(addable_type: "Malt").sum(&:malt_sugar_extract)
  end

  def mcu_b
    ingredient_items.where(addable_type: "Malt").sum(&:malt_mcu_color) / batch
  end

  def mcu
    ( mcu_b * 2.2 ) / 0.26
  end

  def srm
    1.5 * ( mcu ** 0.7 )
  end

  # Hops

  def total_hop
    ingredient_items.where(addable_type: "Hop").sum(&:quantity)
  end

  def total_ibus
    ingredient_items.where(addable_type: "Hop").sum(&:ibus)
  end

  # Yeasts
end
