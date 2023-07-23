class CreateMashes < ActiveRecord::Migration[7.0]
  def change
    create_table :mashes do |t|
      t.decimal :water_grain_ratio, precision: 3, scale: 1, null: false
      t.decimal :temp, precision: 4, scale: 1, null: false
      t.integer :time, null: false
      t.integer :recirculation_time, null: false
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
