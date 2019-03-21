class CategoriesController < ApplicationController
  def show
    @category_list = Category.pluck(:id, :category_name).to_h
    @category = Category.find_by(id: params[:id])
    @categories = Category.all.where.not(id: 1)
    @university = University.find_by(id: params[:university_id])
    @articles = Article.joins(:article_categories, :article_universities)
                    .eager_load(:article_categories, :article_universities)
                    .where("article_universities.university_id = ?", @university.id)
                    .where("article_categories.category_id = ?", @category.id)
                    .order(created_at: :desc)
                    .paginate(page: params[:page], per_page: 5)
  end
end
