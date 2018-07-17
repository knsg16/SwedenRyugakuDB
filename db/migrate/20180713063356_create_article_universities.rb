class CreateArticleUniversities < ActiveRecord::Migration[5.2]
  def change
    create_table :article_universities do |t|
      t.references :article   , index: true, foreign_key: true
      t.references :university, index: true, foreign_key: true
      t.timestamps
    end
  end
end
