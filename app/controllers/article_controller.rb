class ArticleController < ApplicationController
  def index
   @article = Article.new
   @articles_for_admin = Article.join_all
                                .paginate(page: params[:page], per_page: 15)

  # TODO: Formクラスを作成してそっちに役割をもたせる。
   university = params[:university].to_i
   category = params[:category].to_i

   if university > 0 && university != 100
     @articles_for_admin = @articles_for_admin.get_by_university(params[:university])
   end
   if category > 0 && category != 100
     @articles_for_admin = @articles_for_admin.get_by_category(params[:category])
   end
   if university == 100
     @articles_for_admin = Article.join_all
                                  .where("univ_name IS NULL")
                                  .paginate(page: params[:page], per_page: 10)
   end
   if category == 100
     @articles_for_admin = Article.join_all
                                  .where("categories.category_name IS NULL")
                                  .paginate(page: params[:page], per_page: 10)
   end
   session[:last_page] = @articles_for_admin.current_page
  end

  def edit
    @article = Article.find(params[:id])
    page = params[:page]
  end

  def update
    @article = Article.find(params[:id])
    @article.update(update_params)
    redirect_to article_index_path(page: session[:last_page])
  end

  private
  def update_params
    params.require(:article).permit(:id, :subject, :content, :url,
      article_universities_attributes: [:university_id, :_destroy, :id],
      article_categories_attributes: [:category_id, :_destroy, :id])
  end
end
