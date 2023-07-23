# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :malts, dependent: :destroy
  has_many :hops, dependent: :destroy
  has_many :yeasts, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :lots, dependent: :destroy
  has_one :general_configuration, dependent: :destroy

  after_create :generate_general_configuration

  private

  def generate_general_configuration
    GeneralConfiguration.create!(user: self)
  end
end
