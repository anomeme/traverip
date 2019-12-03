class Article < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  mount_uploader :image, ImageUploader
  belongs_to :prefecture
  has_many :pictures
end
