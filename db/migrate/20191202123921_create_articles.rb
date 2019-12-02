class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :detail
      t.string :image
      t.references :prefecture, foreign_key: true
      t.timestamps
    end
  end
end
