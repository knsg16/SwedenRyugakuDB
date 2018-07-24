class ArticleController < ApplicationController
  def index
    @articles_for_admin = Article.joins(:categories, :universities, :blog)
                                 .select("articles.*, categories.category_name,
                                          (universities.name) AS univ_name,
                                          blogs.blog_name")
                                 .order(id: :asc)
                                 .paginate(page: params[:page], per_page: 10)
  end
end
