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

  validates :batch, presence: true

  before_validation :generate_code, on: :create

  # State machine to manage lot status
  aasm column: :status do
    state :creada, initial: true
    state :en_maceracion, :en_coccion, :en_fermentacion

    event :macerar do
      transitions from: :creada, to: :en_maceracion
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
end
