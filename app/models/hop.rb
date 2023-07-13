# == Schema Information
#
# Table name: hops
#
#  id             :bigint           not null, primary key
#  name           :string           not null
#  description    :text             not null
#  aroma_profile  :string
#  flavor_profile :string
#  alpha_acids    :decimal(4, 1)    not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Hop < ApplicationRecord
  belongs_to :user
  has_one :inventory_item, as: :inventoriable, dependent: :destroy
  has_many :ingredient_items, as: :addable, dependent: :destroy
  
  validates :name, :description, :aroma_profile, :flavor_profile, :alpha_acids, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :alpha_acids, numericality: { greater_than: 0 }

  scope :ordered, -> { order(id: :desc) }
  scope :name_ordered, -> { order(name: :asc) }

  after_create :create_inventory_item

  private

  def create_inventory_item
    InventoryItem.create!( available: 0, inventoriable: self )
  end
end
