class CategoriesController < ApplicationController
  def show
    @category = Category.find_by(id: params[:id])
    @categories = Category.all
    @university = University.find_by(id: params[:university_id])
    @articles = Article.joins(:article_categories, :article_universities)
                       .where("article_universities.university_id = ?", @university.id)
                       .where("article_categories.category_id = ?", @category.id)
                       .paginate(page: params[:page], per_page: 5)
  end
end
