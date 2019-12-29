class Message < ApplicationRecord
  belongs_to :lesson
  belongs_to :user

  validates :content, presence: true

  # mount_uploader :image, ImageUploader
end
