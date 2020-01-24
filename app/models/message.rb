class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates:content, presence: true, unless: :image?
  # unless: :image? は、imageカラムがなければ、という意味。
  # →imageカラムがなくて、contentも空だったら保存しない。
  mount_uploader :image, ImageUploader
end
