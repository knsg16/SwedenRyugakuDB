class AddDeleteflagToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :is_delete, :boolean, null: false, default: 0
  end
end
