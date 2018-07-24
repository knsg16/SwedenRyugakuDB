class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.string :blog_name
      t.string :url
      t.boolean :auto_generated

      t.timestamps
    end
  end
end
