# frozen_string_literal: true

class Article < ApplicationRecord
  has_many :stocked,
           class_name: 'Stock', foreign_key: 'stocked_article_id',
           inverse_of: :stock_user, dependent: :destroy
  has_many :stock_user, through: :stocks

  belongs_to :user
  default_scope { order(created_at: :desc) }

  # ----- バリデーション -----
  validates :sweet_name, presence: true
  validates :genre, presence: true
  validates :content, presence: true

  mount_uploader :image, ImagesUploader

  def to_param
    genre
  end
end
