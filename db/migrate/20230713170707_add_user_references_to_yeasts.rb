class AddUserReferencesToYeasts < ActiveRecord::Migration[7.0]
  def change
    add_reference :yeasts, :user, null: false, foreign_key: true
  end
end
