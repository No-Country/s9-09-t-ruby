# == Schema Information
#
# Table name: yeasts
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  dosage      :decimal(4, 1)
#  type        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Yeast < ApplicationRecord
  validates :name, :description, :dosage, :type, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :dosage, numericality: { greater_than: 0 }  
end
