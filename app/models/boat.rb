class Boat < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :name, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
