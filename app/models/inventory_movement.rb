# == Schema Information
#
# Table name: inventory_movements
#
#  id                :bigint           not null, primary key
#  quantity          :integer          not null
#  movement_type     :integer          not null
#  inventory_item_id :bigint           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class InventoryMovement < ApplicationRecord
  belongs_to :inventory_item

  validates :quantity, :movement_type, presence: true
  validates :quantity, numericality: { greater_than: 0 }

  enum movement_type: { input: 1, output: 2 }

  after_create :update_inventory_item_available

  private

  def update_inventory_item_available
    current_stock = inventory_item.available
    inventory_item.update!(available: current_stock + quantity) if movement_type == "input"
    inventory_item.update!(available: current_stock - quantity) if movement_type == "output"
  end
end
