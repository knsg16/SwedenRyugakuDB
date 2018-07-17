class CreateUniversityCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :university_categories do |t|

      t.timestamps
    end
  end
end
