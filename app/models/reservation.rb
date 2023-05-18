class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :tutor

  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :tutor_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :date, presence: true
end
