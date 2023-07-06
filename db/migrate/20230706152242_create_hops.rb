class CreateHops < ActiveRecord::Migration[7.0]
  def change
    create_table :hops do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :aroma_profile
      t.string :flavor_profile
      t.decimal :alpha_acids, precision: 4, scale: 1, null: false

      t.timestamps
    end
  end
end
