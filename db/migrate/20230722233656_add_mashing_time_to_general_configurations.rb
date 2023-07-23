class AddMashingTimeToGeneralConfigurations < ActiveRecord::Migration[7.0]
  def change
    add_column :general_configurations, :mashing_time, :integer, default: 60
  end
end
