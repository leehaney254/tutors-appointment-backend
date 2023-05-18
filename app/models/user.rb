class User < ApplicationRecord
  has_secure_password
  has_many :tutors
  has_many :reservations, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
end
