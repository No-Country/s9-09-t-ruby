# == Schema Information
#
# Table name: general_configurations
#
#  id                     :bigint           not null, primary key
#  efficiency_extract     :decimal(4, 1)    default(70.0)
#  evaporation_percentage :decimal(4, 1)    default(20.0)
#  bioling_time           :integer          default(60)
#  loss_temp              :decimal(4, 1)    default(0.0)
#  grain_temp             :decimal(4, 1)    default(20.0)
#  water_grain_ratio      :decimal(3, 1)    default(3.0)
#  mashing_temp           :decimal(4, 1)    default(68.0)
#  sparging_temp          :decimal(4, 1)    default(70.0)
#  sparging_time          :integer          default(20)
#  chilling_time          :integer          default(30)
#  turbiduty_loss         :integer          default(3)
#  user_id                :bigint           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class GeneralConfiguration < ApplicationRecord
  belongs_to :user

  validates :efficiency_extract,
  :evaporation_percentage,
  :bioling_time,
  :loss_temp,
  :grain_temp,
  :water_grain_ratio,
  :mashing_temp,
  :sparging_temp,
  :sparging_time,
  :chilling_time,
  :turbiduty_loss, presence: true, numericality: { greater_than_or_equal_to: 0 }   

end
