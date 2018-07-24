class Article < ApplicationRecord
  validates :subject, presence: true, length: {maximum: 50}
  validates :content, presence: true, length: {maximum: 500}
  belongs_to :blog
  has_many :article_universities
  has_many :universities, through: :article_universities
  has_many :article_categories
  has_many :categories, through: :article_categories

  #default_scope -> { order(created_at: :desc) }
end
