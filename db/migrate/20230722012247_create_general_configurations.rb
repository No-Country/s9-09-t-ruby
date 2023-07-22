class CreateGeneralConfigurations < ActiveRecord::Migration[7.0]
  def change
    create_table :general_configurations do |t|
      t.decimal :efficiency_extract, precision: 4, scale: 1, default: 70.0
      t.decimal :evaporation_percentage, precision: 4, scale: 1, default: 20.0
      t.integer :bioling_time, default: 60
      t.decimal :loss_temp, precision: 4, scale: 1, default: 0
      t.decimal :grain_temp, precision: 4, scale: 1, default: 20.0
      t.decimal :water_grain_ratio, precision: 3, scale: 1, default: 3.0
      t.decimal :mashing_temp, precision: 4, scale: 1, default: 68.0
      t.decimal :sparging_temp, precision: 4, scale: 1, default: 70.0
      t.integer :sparging_time, default: 20
      t.integer :chilling_time, default: 30
      t.integer :turbiduty_loss, default: 3
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
