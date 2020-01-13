# frozen_string_literal: true

class Article < ApplicationRecord
  # ストック
  has_many :stocked,
           class_name: 'Stock', foreign_key: 'stocked_article_id',
           inverse_of: :stocked_article, dependent: :destroy
  has_many :stock_users, through: :stocked, source: :stock_user

  # いいね
  has_many :liked,
           class_name: 'Like', foreign_key: 'liked_article_id',
           inverse_of: :liked_article, dependent: :destroy
  has_many :like_users, through: :liked, source: :like_user

  # コメント
  has_many :comments,
           foreign_key: 'article_id', inverse_of: :article, dependent: :destroy
  has_many :comment_users, through: :comments, source: :user
  
  belongs_to :user

  # ----- バリデーション -----
  validates :sweet_name, presence: true
  validates :genre, presence: true
  validates :content, presence: true

  mount_uploader :image, ImagesUploader
end
