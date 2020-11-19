class Boat < ApplicationRecord
  has_many :bookings, dependent: :destroy
  belongs_to :user
  has_one_attached :image
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :image, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
