class AddAttenuationToYeasts < ActiveRecord::Migration[7.0]
  def change
    add_column :yeasts, :attenuation, :integer, null: false
  end
end
