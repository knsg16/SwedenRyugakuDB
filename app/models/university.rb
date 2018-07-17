class University < ApplicationRecord
  validates :name, presence: true, length: {maximum: 50}
  has_many :articles, through: :article_universities
  has_many :article_universities
  accepts_nested_attributes_for :article_universities
end
