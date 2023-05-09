class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :tutor

  validates :user_id, presence: true
  validates :tutor_id, presence: true
  validates :date, presence: true
end
