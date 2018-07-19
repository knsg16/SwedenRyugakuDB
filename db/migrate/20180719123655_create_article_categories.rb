class CreateArticleCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :article_categories do |t|
      t.references :articles   , index: true, foreign_key: true
      t.references :categories, index: true, foreign_key: true
      t.timestamps
    end
  end
end
