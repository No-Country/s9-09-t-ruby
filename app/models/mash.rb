# == Schema Information
#
# Table name: mashes
#
#  id                 :bigint           not null, primary key
#  water_grain_ratio  :decimal(3, 1)    not null
#  temp               :decimal(4, 1)    not null
#  time               :integer          not null
#  recirculation_time :integer          not null
#  recipe_id          :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Mash < ApplicationRecord
  belongs_to :recipe
  has_many :mash_steps, dependent: :destroy

  validates :water_grain_ratio, :temp, :time, :recirculation_time, presence: true, numericality: { greater_than: 0 }
  # validates :mash_steps, presence: true
  accepts_nested_attributes_for :mash_steps, reject_if: :all_blank, allow_destroy: true
end
