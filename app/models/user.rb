class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  enum goal: [ :healthy, :lose_weight, :gain_weight, :gain_muscle, :low_salt ]
  validates :username, presence: true, uniqueness: true
  validates :height, presence: true
  validates :weight, presence: true
  validates :goal, presence: true
  has_many :choices
end
