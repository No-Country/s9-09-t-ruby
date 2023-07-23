# == Schema Information
#
# Table name: mash_steps
#
#  id          :bigint           not null, primary key
#  start_temp  :decimal(4, 1)    not null
#  final_temp  :decimal(4, 1)    not null
#  length_time :integer          not null
#  mash_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class MashStep < ApplicationRecord
  belongs_to :mash

  validates :start_temp, :final_temp, :length_time, presence: true, numericality: { greater_than: 0 }
end
