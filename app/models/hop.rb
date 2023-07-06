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
  validates :name, :description, :aroma_profile, :flavor_profile, :alpha_acids, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :alpha_acids, numericality: { greater_than: 0 }

  scope :ordered, -> { order(id: :desc) }
end
