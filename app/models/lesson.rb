class Lesson < ApplicationRecord
  has_many :lesson_users
  has_many :users, through: :lesson_users

  validates :name, presence: true, uniqueness: true
end
