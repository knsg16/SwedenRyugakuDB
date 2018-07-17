class DropTableArticleUniversity < ActiveRecord::Migration[5.2]
  def change
    drop_table :article_universities
  end
end
