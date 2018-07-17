class ChangeContentToArticles < ActiveRecord::Migration[5.2]
  #変更後の型
  def up
    change_column :articles, :content, :text, null: false
  end

  #変更前の型
  def down
    change_column :articles, :content, :string, null: false
  end
end
