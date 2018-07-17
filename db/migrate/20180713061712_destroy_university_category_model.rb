class DestroyUniversityCategoryModel < ActiveRecord::Migration[5.2]
  def change
    drop_table :university_categories
  end
end
 
