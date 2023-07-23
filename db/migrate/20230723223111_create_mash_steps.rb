class CreateMashSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :mash_steps do |t|
      t.decimal :start_temp, precision: 4, scale: 1, null: false
      t.decimal :final_temp, precision: 4, scale: 1, null: false
      t.integer :length_time, null: false
      t.references :mash, null: false, foreign_key: true

      t.timestamps
    end
  end
end
