class UniversitiesController < ApplicationController
  def show
    @university = University.find(params[:id])
    @categories = Category.all

    @articles = Article.joins(:article_universities)
                       .where("article_universities.university_id = ?", params[:id])
  end

  def new
  end

  def create
    redirect_to :action => "show", :id => params[:university][:id]
    #params[:パラメータA][:パラメータB]
    #これは[:パラメータA]の配列の[:パラメータB]をもってきてる
  end

end
