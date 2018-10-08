class Article < ApplicationRecord
  validates :subject, presence: true, length: {maximum: 50}
  belongs_to :blog
  has_many :article_universities
  has_many :universities, through: :article_universities
  has_many :article_categories
  has_many :categories, through: :article_categories
  enum university: { すべての大学:0, ウプサラ大学: 1, ストックホルム大学: 2, 大学タグ無し: 100}
  enum category: { すべてのカテゴリー:0, 持物:1, 準備:2, 授業:3,
                   寮:4, 体験談:5, 文化:6, 生活:7, カテゴリータグ無し: 100}
  scope :get_by_university, ->(university) {
    joins(:categories, :universities, :blog)
    .where("universities.id = ?", university)
  }
  scope :get_by_category, ->(category) {
    joins(:categories, :universities, :blog)
    .where("categories.id = ?", category)
  }

end
