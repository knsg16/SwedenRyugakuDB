class BlogController < ApplicationController
  def index
    @blogs = Blog.all.paginate(page: params[:page], per_page: 10)
  end
end
