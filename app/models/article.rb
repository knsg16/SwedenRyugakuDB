class Article < ApplicationRecord
  validates :subject, presence: true, length: {maximum: 50}
  validates :content, presence: true, length: {maximum: 500}
  has_many :universities, through: :article_universities
  has_many :article_universities
end
