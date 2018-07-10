class UniversitiesController < ApplicationController
  def show
    @univerity = University.find(params[:id])
  end

  def new
  end

  def create
    redirect_to :action => "show", :id => params[:university][:id]
  end

end
