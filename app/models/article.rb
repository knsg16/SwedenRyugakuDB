class Article < ApplicationRecord
  validates :subject, presence: true, length: {maximum: 50}
  belongs_to :blog
  has_many :article_universities
  has_many :universities, through: :article_universities
  has_many :article_categories
  has_many :categories, through: :article_categories
  accepts_nested_attributes_for :article_universities, allow_destroy: true
  accepts_nested_attributes_for :article_categories, allow_destroy: true

  enum university: { すべての大学:0, ウプサラ大学: 3, ストックホルム大学: 2, 大学タグ無し: 1}
  enum category: { すべてのカテゴリー:0, 持物:8, 準備:2, 授業:3,
                   寮:4, 体験談:5, 文化:6, 生活:7, カテゴリータグ無し: 1}

  scope :get_by_university, ->(university) {
    self.joins(:categories, :universities, :blog)
        .where("universities.id = ?", university)
  }
  scope :get_by_category, ->(category) {
    self.joins(:categories, :universities, :blog)
        .where("categories.id = ?", category)
  }
  scope :join_all, ->{
    self.left_joins(:categories, :universities, :blog)
        .select("articles.*, categories.category_name,
                 (universities.name) AS univ_name, blogs.blog_name")
        .order(id: :asc)
  }
end
