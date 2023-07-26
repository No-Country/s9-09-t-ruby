class AddRowOrderToTodos < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :row_order, :integer
  end
end
