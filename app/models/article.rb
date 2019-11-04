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

  belongs_to :user
  default_scope { order(created_at: :desc) }

  # ----- バリデーション -----
  validates :sweet_name, presence: true
  validates :genre, presence: true
  validates :content, presence: true

  mount_uploader :image, ImagesUploader
end
