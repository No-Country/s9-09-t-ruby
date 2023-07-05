# == Schema Information
#
# Table name: malts
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  extract     :decimal(3, 1)
#  color       :decimal(4, 1)
#  ph          :decimal(2, 1)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Malt < ApplicationRecord

  validates :name, :description, :extract, :color, :ph, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :extract, :color, :ph, numericality: { greater_than: 0 }

  scope :ordered, -> { order(id: :desc) }
end
