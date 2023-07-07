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
#
class Yeast < ApplicationRecord
  validates :name, :description, :dosage, :yeast_type, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :dosage, numericality: { greater_than: 0 }

  enum yeast_type: { lager: 1, ale: 2 }

  scope :ordered, -> { order(id: :desc) }
end
