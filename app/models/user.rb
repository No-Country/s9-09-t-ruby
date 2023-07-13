class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :malts, dependent: :destroy
  has_many :hops, dependent: :destroy
  has_many :yeasts, dependent: :destroy
  has_many :recipes, dependent: :destroy
end
