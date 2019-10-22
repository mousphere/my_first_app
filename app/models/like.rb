class Like < ApplicationRecord
  belongs_to :like_user, class_name: 'User'
  belongs_to :liked_article, class_name: 'Article'
  validates :like_user_id, presence: true
  validates :liked_article_id, presence: true
end
