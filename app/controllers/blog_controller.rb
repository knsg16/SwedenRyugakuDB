class BlogController < ApplicationController
  def index
    @blogs = Blog.all.paginate(page: params[:page], per_page: 10)
  end

  def new
    @blog = Blog.new
  end

  def create
    blog = Blog.new(create_params)
    blog.save
    redirect_to blog_index_path
  end

  private
  def create_params
    params.require(:blog).permit(:blog_name, :url, :auto_generated)
  end
end
