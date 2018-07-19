class Category < ApplicationRecord
  has_many :articles, through: :article_categories
  has_many :article_categories
  accepts_nested_attributes_for :article_categories
end
