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
#  status      :string
#
class Recipe < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :ingredient_items, dependent: :destroy
  has_many :lots, dependent: :destroy
  delegate :general_configuration, to: :user
  has_one :mash, dependent: :destroy

  validates :name, :description, :style, :batch, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :batch, numericality: { greater_than: 0 }

  scope :ordered, -> { order(id: :desc) }
  scope :filter_by_status, -> (status) { where("status = ?", status) }

  # State machine to manage lot status
  aasm column: :status do
    state :en_edicion, initial: true
    state :terminada

    event :terminar do
      transitions from: :en_edicion, to: :terminada, guard: :has_ingredients_and_mashing?, after: :update_attributes
    end
  end

  # Data in lot creation
  # Ingredients quantities
  def ingredient_items_quantities(batch)
    quantities = {
      "malts" => {},
      "hops" => {},
      "yeast" => {}
    }
    # Add quantities from malts ingredients
    ingredient_items.where(addable_type: "Malt").each do |malt|
      quantities["malts"].store(malt.addable.name, malt_ingredient_quantity(malt.malt_percentage, malt.addable.extract, batch).round(2))
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

  # Data in recipe design
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

  private

  def update_attributes
    self.update(
      og: computed_og,
      fg: computed_fg,
      abv: computed_abv,
      color: srm,
      ibus: total_ibus
    )
  end

  # Mashing
  def has_a_mash?
    !mash.nil?
  end

  def has_ingredients_and_mashing?
    has_one_malt? and has_one_hop? and has_one_yeast? and has_a_mash?
  end
end
