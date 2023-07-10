# == Schema Information
#
# Table name: inventory_items
#
#  id                 :bigint           not null, primary key
#  available          :integer
#  inventoriable_type :string
#  inventoriable_id   :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  recipe_id          :bigint           not null
#
class InventoryItem < ApplicationRecord
  belongs_to :inventoriable, polymorphic: true
  has_many :inventory_movements, dependent: :destroy
end
