class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|

      t.string  :subject, null: false
      t.string  :picture, null: true
      t.string  :content, null: false
      t.string  :url    , null: true
      t.integer :blog_id, null: true
      t.timestamps
    end
  end
end
