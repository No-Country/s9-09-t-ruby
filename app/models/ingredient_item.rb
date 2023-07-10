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
#
class IngredientItem < ApplicationRecord
  belongs_to :addable, polymorphic: true
  belongs_to :recipe
end
