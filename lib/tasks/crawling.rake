namespace :crawling do
  task :ameba => :environment do
    blog_controller = BlogController.new
    blog_ids = Blog.all.map(&:id)
    blog_ids.each { |blog_id| blog_controller.scraping(blog_id) }
  end
end
