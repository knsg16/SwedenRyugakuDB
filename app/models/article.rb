class Article < ApplicationRecord
  has_many :universities, through: :article_universities
  has_many :article_universities
end
