require 'nokogiri'
require 'open-uri'

class BlogController < ApplicationController
  def index
    @blogs = Blog.all.paginate(page: params[:page], per_page: 20)
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
    url = Blog.find(blog_id).url
    #https://ameblo.jp/以下のURLを取得している
    str_list = url.split("/")
    next_url = [str_list[3], str_list[4]].join("/")
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
      break if doc.at('skin-pagination').nil?
      break if doc.at('.skin-paginationNexts li a')[:class]&.include?("is-disabled")&.present?
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
    picture = doc.search('.skin-entryBody p a')[0].attribute("href").value if doc.search('.skin-entryBody p a')[0].present?
    # content1 = doc.search('.skin-entryBody p')[0].inner_text
    result = ""
    contents = doc.search('.skin-entryBody p')
    contents.each do |content|
      result += content.inner_text.delete("\n")
      break if result.length > 500
    end
    print_log(subject, picture, result)
    save_article(subject, picture, result, current_page)
  end

  private

  def save_article(subject, picture, result, current_page)
    Article.where(subject: subject).first_or_initialize do |article|
      article.picture = picture
      article.content = result
      article.url = current_page
      article.blog_id = blog_id
      if article.save
        new_article_id = Article.last.id
        ArticleUniversity.create(article_id: new_article_id, university_id: 1)
        ArticleCategory.create(article_id: new_article_id, category_id: 1)
      end
    end
  end

  def print_log(subject, picture, result)
    p subject
    p picture
    p result
  end

  def create_params
    params.require(:blog).permit(:blog_name, :url, :auto_generated)
  end

end
