class StaticPagesController < ApplicationController
  def home
    @university = University.new
    #@university.id = params[:id]
  end

  def about
  end

  def contact
  end
end
