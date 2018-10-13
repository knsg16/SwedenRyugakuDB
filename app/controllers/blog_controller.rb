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
    scraping(blog.id)
    redirect_to blog_index_path
  end

  def scraping(blog_id)
    @links = []
    next_url = Blog.find(blog_id).url
    #next_url = "peperoy/entrylist.html"
    while true
      current_page = "https://ameblo.jp/" + next_url
      charset = nil

      html = open(current_page) do |f|
          charset = f.charset
          f.read
      end

      doc = Nokogiri::HTML.parse(html, nil, charset)
      doc.xpath('//div[@data-uranus-component="entryItem"]').each do |node|
        url = node.css('h2 a')[0][:href]
        @links.push(url)
        p url
      end

      #paginationで次が無くなったらbreak
      break if doc.at('.skin-paginationNexts li a')[:class].include?("is-disabled").present?
      next_url = doc.at('.skin-paginationNexts li a')[:href]
      p next_url
    end
    @links.each do |link|
      get_blog(link, blog_id)
    end
  end

  def get_blog(link, blog_id)
    current_page = "https://ameblo.jp/" + link
    charset = nil

    html = open(current_page) do |f|
        charset = f.charset
        f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)

    #ここから各記事の画像とか本文とか取ってきて保存する。
    subject = doc.at('.skin-entryTitle').inner_text
    picture = doc.search('.skin-entryBody div a')[0].attribute("href").value if doc.search('.skin-entryBody div a')[0].present?
    p subject
    p picture

    Article.where(subject: subject).first_or_create do |article|
      article.picture = picture
      article.content = ""
      article.url = current_page
      article.blog_id = blog_id
      p article
    end

    new_article_id = Article.last.id
    ArticleUniversity.create(article_id: new_article_id, university_id: 1)
    ArticleCategory.create(article_id: new_article_id, category_id: 1)

  end

  private
  def create_params
    params.require(:blog).permit(:blog_name, :url, :auto_generated)
  end
end
