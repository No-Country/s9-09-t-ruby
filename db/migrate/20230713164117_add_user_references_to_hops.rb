class AddUserReferencesToHops < ActiveRecord::Migration[7.0]
  def change
    add_reference :hops, :user, null: false, foreign_key: true
  end
end
