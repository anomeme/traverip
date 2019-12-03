class Picture < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :article
  belongs_to :user
end
