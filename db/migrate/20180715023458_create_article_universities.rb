class CreateArticleUniversities < ActiveRecord::Migration[5.2]
  def change
    create_table :article_universities do |t|
      t.references :article, foreign_key: true, index: true
      t.references :university, foreign_key: true, index: true
      t.timestamps
    end
  end
end
