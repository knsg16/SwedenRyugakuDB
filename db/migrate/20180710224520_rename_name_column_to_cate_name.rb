class RenameNameColumnToCateName < ActiveRecord::Migration[5.2]
  def change
    rename_column :categories, :name, :category_name
  end
end
