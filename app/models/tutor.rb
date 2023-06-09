class Tutor < ApplicationRecord
  has_many :users
  has_many :reservations, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :image, presence: true
  validates :speciality, presence: true
  validates :bio, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
