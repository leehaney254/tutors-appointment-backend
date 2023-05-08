class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :tutor

  validates :user_id, presence: true
  validates :tutor_id, presence: true
  validates :date, presence: true, date: { after: Date.today, message: "can't be in the past" }
end
