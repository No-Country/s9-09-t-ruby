# == Schema Information
#
# Table name: todos
#
#  id          :bigint           not null, primary key
#  todo_type   :integer          not null
#  status      :string
#  transitions :hstore           is an Array
#  lot_id      :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Todo < ApplicationRecord
  include AASM
  include RankedModel

  ranks :row_order

  belongs_to :lot

  validates :todo_type, presence: true

  enum todo_type: {
    maceracion: 1,
    recirculacion: 2,
    lavado: 3,
    coccion: 4,
    enfriamiento: 5,
    fermentacion: 6,
    maduracion: 7,
    carbonatacion: 8
  }

  # Manage todos status
  aasm column: :status do
    state :pendiente, initial: true
    state :terminada

    after_all_transitions :log_status_change

    event :terminar do
      transitions from: :pendiente, to: :terminada, after: :update_lot_status
    end
  end

  private

  def update_lot_status
    if todo_type == "maceracion" or todo_type == "enfriamiento"
      event = {
        "maceracion" => "cocinar",
        "enfriamiento" => "fermentar"
      }
      # debugger
      lot.send "#{event[todo_type]}!"
    end
  end

  def log_status_change
    transitions.push(
      {
        from_state: aasm.from_state,
        to_state: aasm.to_state,
        current_event: aasm.current_event,
        timestamp: Time.zone.now
      }
    )
  end
end
