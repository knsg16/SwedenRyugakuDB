class CategoriesController < ApplicationController
  def show
    @category = Category.find_by(id: params[:id])
    @categories = Category.all
    @university = University.find_by(id: params[:university_id])
  end
end
