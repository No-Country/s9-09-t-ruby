class CreateTodos < ActiveRecord::Migration[7.0]
  enable_extension 'hstore' unless extension_enabled?('hstore')
  def change
    create_table :todos do |t|
      t.integer :todo_type, null: false
      t.string :status
      t.hstore :transitions, array: true, default: []
      t.references :lot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
