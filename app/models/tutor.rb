class Tutor < ApplicationRecord
  has_many :user

  validates :name, presence: true
  validates :image, presence: true
  validates :speciality, presence: true
  validates :bio, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
