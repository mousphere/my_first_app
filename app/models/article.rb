# frozen_string_literal: true

class Article < ApplicationRecord
  include ArticlesHelper

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

  VALID_URL_REGEX = %r{https?://[\w/:%\#\$&?()~.=+-]+|\A\z}.freeze
  validates :url, format: { with: VALID_URL_REGEX }

  validates :prefecture, presence: true, if: :address_exists

  # ----- 画像アップロード -----

  mount_uploader :image, ImagesUploader

  # ----- 関数一覧 -----

  def address_exists
    address.present?
  end

  def converted_genre
    genre_list.find { |_key, value| value == genre }[0]
  end

  def arranged_address
    prefecture_list.find { |_key, value| value == prefecture }[0] + address
  end

  def self.used_prefectures
    Article.select(:prefecture).group(:prefecture).where.not(prefecture: nil)
  end

  def self.choose(genre, prefecture, query)
    if genre.present?
      Article.where(genre: genre)
    elsif prefecture.present?
      Article.where(prefecture: prefecture)
    elsif query.result
      query.result
    else
      Article.all
    end
  end

  def self.order_arrange_by_option(articles, params_page, per, option)
    if option.zero?
      @articles = articles.page(params_page).per(per).order(created_at: :desc)
    elsif option == 1
      @articles = articles.page(params_page).per(per).order(like_counts: :desc)
    end
    @articles
  end
end
