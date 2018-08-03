require 'nokogiri'
require 'open-uri'

class StaticPagesController < ApplicationController
  def home
    @university = University.new
  end

  def about
    @about = []
    url = 'https://qiita.com/search?page=2&q=ruby'

    charset = nil

    html = open(url) do |f|
        charset = f.charset
        f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)
    doc.xpath('//h1[@class="searchResult_itemTitle"]').each do |node|
      @about.push(node.css('a').inner_text)
      p node.css('a').inner_text
    end
  end

  def contact
  end
end
