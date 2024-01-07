class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :body, presence: true, length: { maximum: 1000 }
end
