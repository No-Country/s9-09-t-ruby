# == Schema Information
#
# Table name: yeasts
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  dosage      :decimal(4, 1)
#  yeast_type  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  attenuation :integer          not null
#  user_id     :bigint           not null
#
class Yeast < ApplicationRecord
  belongs_to :user
  has_one :inventory_item, as: :inventoriable, dependent: :destroy
  has_many :ingredient_items, as: :addable, dependent: :destroy

  validates :name, :description, :dosage, :yeast_type, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :dosage, numericality: { greater_than: 0 }

  enum yeast_type: { lager: 1, ale: 2 }

  scope :ordered, -> { order(id: :desc) }
  scope :name_ordered, -> { order(name: :asc) }


  after_create :create_inventory_item

  private

  def create_inventory_item
    InventoryItem.create!( available: 0, inventoriable: self )
  end
end
