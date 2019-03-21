class UniversitiesController < ApplicationController
  def show
    @university = University.find(params[:id])
    @categories = Category.all.where.not(id: 1)
    @category_list = Category.pluck(:id, :category_name).to_h
    @articles = Article.joins(:article_categories, :article_universities)
                    .eager_load(:article_categories, :article_universities)
                       .where("article_universities.university_id = ?", params[:id])
                       .order(created_at: :desc)
                       .paginate(page: params[:page], per_page: 6)
  end

  def new
  end

  def create
    redirect_to :action => "show", :id => params[:university][:id]
    #params[:パラメータA][:パラメータB]
    #これは[:パラメータA]の配列の[:パラメータB]をもってきてる
  end

  def index
    @universities = University.all.where.not(id: 1)
  end

end
