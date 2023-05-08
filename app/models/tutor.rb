class Tutor < ApplicationRecord
  has_many :user

  validate :name, presene: true
  validate :image, presene: true
  validate :speciality, presene: true
  validate :bio, presene: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
