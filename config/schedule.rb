# cronログを吐き出す場所
set :output, File.join(Whenever.path, "log", "cron.log")
# ジョブの実行環境の指定
set :environment, :development

# 1分毎にアメブロの新着記事をとってきてArticleのModelに保存する
every 1.minutes do
  begin
    rake "crawling:ameba"
  rescue => e
    raise e
  end
end
