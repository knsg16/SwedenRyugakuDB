require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @article = Article.new(subject: "東大の経済学の授業",
                           picture: "todai.png",
                           content: "経済学の授業",
                           url: "www.toudai.com",
                           blog_id: "2")
  end

  test "subject should be present" do
    @article.subject = "   "
    assert_not @article.valid?
  end

  test "content should be present" do
    @article.content = "   "
    assert_not @article.valid?
  end

  test "subject should not be too long" do
    @article.subject = "a" * 51
    assert_not @article.valid?
  end

  test "content should not be too long" do
    @article.content = "a" * 501
    assert_not @article.valid?
  end
end
