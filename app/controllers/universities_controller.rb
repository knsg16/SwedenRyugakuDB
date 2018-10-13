class UniversitiesController < ApplicationController
  def show
    @university = University.find(params[:id])
    @categories = Category.all.where.not(id: 1)

    @articles = Article.joins(:article_universities)
                       .where("article_universities.university_id = ?", params[:id])
                       .order(created_at: :desc)
                       .paginate(page: params[:page], per_page: 5)
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
