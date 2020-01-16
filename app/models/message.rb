class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates:content, presence: true, unless: :image?
  # unless: :image? は、imageカラムがなければoutと言うこと
  mount_uploader :image, ImageUploader
end
