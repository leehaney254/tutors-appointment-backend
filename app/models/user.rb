class User < ApplicationRecord
  has_many :tutors

  validates :name, presence: true
end
