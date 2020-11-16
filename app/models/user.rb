class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: false, uniqueness: true
  has_many :bookings
  has_many :owned_boats, class_name: 'Boat'
  has_many :rented_boats, through: :bookings, source: :boat
end
