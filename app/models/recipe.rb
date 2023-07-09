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
  validates :name, :description, :style, :batch, :og, :fg, :abv, :color, :ibus, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :batch, :og, :fg, :abv, :color, :ibus, numericality: { greater_than: 0 }

  scope :ordered, -> { order(id: :desc) }
end
