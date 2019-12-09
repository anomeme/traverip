class Article < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  mount_uploader :image, ImageUploader
  mount_uploader :sub_image1, ImageUploader
  mount_uploader :sub_image2, ImageUploader
  belongs_to :prefecture
  has_many :pictures, dependent: :destroy
  has_many :favorites
  has_many :users, through: :favorites
end
