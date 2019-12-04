class AddSubImagesToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :sub_image1, :string
    add_column :articles, :sub_image2, :string
  end
end
