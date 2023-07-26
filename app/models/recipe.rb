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
  include Recipes::Malts
  include Recipes::Hops
  include Recipes::BeerAttributes
  include Recipes::ValidateIngredients
  include Recipes::IngredientQuantities

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

  # State machine to manage recipe status
  aasm column: :status do
    state :en_edicion, initial: true
    state :terminada

    event :terminar do
      transitions from: :en_edicion, to: :terminada, guard: :has_ingredients_and_mashing?, after: :update_attributes
    end
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
end
