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
#  user_id     :bigint           not null
#
class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredient_items, dependent: :destroy
  has_many :lots, dependent: :destroy
  delegate :general_configuration, to: :user
  has_one :mash, dependent: :destroy

  validates :name, :description, :style, :batch, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :batch, numericality: { greater_than: 0 }


  scope :ordered, -> { order(id: :desc) }


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

  # Malts
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

  # Hops

  def total_hop
    has_one_hop? ? ingredient_items.where(addable_type: "Hop").sum(&:quantity) : 0
  end

  def total_ibus
    has_one_hop? ? ingredient_items.where(addable_type: "Hop").sum(&:ibus) : 0
  end

  def has_one_malt?
    ingredient_items.where(addable_type: "Malt").count > 0
  end

  def has_one_hop?
    ingredient_items.where(addable_type: "Hop").count > 0
  end

  def has_one_yeast?
    ingredient_items.where(addable_type: "Yeast").count > 0
  end

end
