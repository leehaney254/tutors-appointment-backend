class User < ApplicationRecord
  has_many :tutors

  validate :name, presene: true
end
