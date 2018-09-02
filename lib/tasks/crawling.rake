namespace :crawling do
  task :ameba => :environment do
    #URLをブログModelから取ってくる必要がある。戻り値は、配列
    url = 'https://ameblo.jp/gonshidayo22/entrylist.html'

    charset = nil

    html = open(url) do |f|
        charset = f.charset
        f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)
    #記事名とコンテンツと記事のURL（と画像）をとってきてArticleのModelに保存する
      doc.xpath('//h2[@data-uranus-component="entryItemTitle"]').each do |node|
      p node.css('a').inner_text
      p "https://ameblo.jp/#{node.css('a')[0][:href]}"
    end

  end
end
