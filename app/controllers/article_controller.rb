class ArticleController < ApplicationController
  def index
    @articles_for_admin = Article.joins(:categories, :universities)
                                 .select("articles.*, categories.category_name,
                                          (universities.name) AS univ_name")

    #.all.order(id: :asc)
  end
end
