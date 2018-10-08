require 'nokogiri'
require 'open-uri'
require 'byebug'

class StaticPagesController < ApplicationController
  def home
    @university = University.new
  end

  def about
    @links = []
    next_url = "peperoy/entrylist.html"
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
      blog_id = 9
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

    ## TODO: saveできないからできるように。blog_idの取っくる方法。
    Article.where(subject: subject).first_or_create do |article|
      article.picture = picture
      article.content = ""
      article.url = current_page
      article.blog_id = blog_id
      p article
    end
  end

  def contact
  end

end
