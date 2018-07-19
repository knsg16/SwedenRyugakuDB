class Article < ApplicationRecord
  validates :subject, presence: true, length: {maximum: 50}
  validates :content, presence: true, length: {maximum: 500}
  has_many :universities, through: :article_universities
  has_many :article_universities
  has_many :categories, through: :article_categories
  has_many :article_categories
  default_scope -> { order(created_at: :desc) }
end
