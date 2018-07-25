class ArticleController < ApplicationController
  def index
   #@articles_for_admin = Article.joins(:categories, :universities, :blog)
   @articles_for_admin = Article.left_joins(:categories, :universities, :blog)
                                .select("articles.*, categories.category_name,
                                         (universities.name) AS univ_name,
                                         blogs.blog_name")
                                .order(id: :asc)
                                .paginate(page: params[:page], per_page: 10)
   if params[:university].to_i > 0 && params[:university].to_i != 100
     @articles_for_admin = @articles_for_admin.get_by_university(params[:university])
   end
   if params[:category].to_i > 0 && params[:category].to_i != 100
     @articles_for_admin = @articles_for_admin.get_by_category(params[:category])
   end
   if params[:university].to_i == 100
     @articles_for_admin = Article.left_joins(:categories, :universities, :blog)
                                  .select("articles.*, categories.category_name,
                                           (universities.name) AS univ_name,
                                           blogs.blog_name")
                                  .order(id: :asc)
                                  .where("univ_name IS NULL")
                                  .paginate(page: params[:page], per_page: 10)
   end
   if params[:category].to_i == 100
     @articles_for_admin = Article.left_joins(:categories, :universities, :blog)
                                  .select("articles.*, categories.category_name,
                                           (universities.name) AS univ_name,
                                           blogs.blog_name")
                                  .order(id: :asc)
                                  .where("categories.category_name IS NULL")
                                  .paginate(page: params[:page], per_page: 10)
   end
  end
end
