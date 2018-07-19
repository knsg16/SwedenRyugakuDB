class RenameColumnInArticleCategoriesTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :article_categories, :articles_id, :article_id
    rename_column :article_categories, :categories_id, :category_id
  end
end
