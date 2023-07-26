# == Schema Information
#
# Table name: lots
#
#  id         :bigint           not null, primary key
#  code       :string           not null
#  batch      :integer          not null
#  status     :string
#  recipe_id  :bigint           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Lot < ApplicationRecord
  include AASM

  belongs_to :recipe
  belongs_to :user
  has_many :todos, dependent: :destroy

  validates :batch, presence: true

  before_validation :generate_code, on: :create
  after_create :generate_todos

  scope :ordered, -> { order(id: :desc) }

  # State machine to manage lot status
  aasm column: :status do
    state :creado, initial: true
    state :en_maceracion, :en_coccion, :en_fermentacion

    event :macerar do
      transitions from: :creado, to: :en_maceracion
    end

    event :cocinar do
      transitions from: :en_maceracion, to: :en_coccion
    end

    event :fermentar do
      transitions from: :en_coccion, to: :en_fermentacion
    end
  end

  private

  def generate_code
    self.code = SecureRandom.hex(8)
  end

  def generate_todos
    todos.todo_types.each {|key, value| todos.create!(todo_type: value)}
  end
end
