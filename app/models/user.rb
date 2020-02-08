# frozen_string_literal: true

class User < ApplicationRecord
  # 記事
  has_many :articles, dependent: :destroy

  # ストック
  has_many :stocks,
           foreign_key: 'stock_user_id', inverse_of: :stock_user, dependent: :destroy
  has_many :stocked_articles, through: :stocks, source: :stocked_article

  # いいね
  has_many :likes,
           foreign_key: 'like_user_id', inverse_of: :like_user, dependent: :destroy
  has_many :liked_articles, through: :likes, source: :liked_article

  # コメント
  has_many :comments,
           foreign_key: 'user_id', inverse_of: :user, dependent: :destroy
  has_many :commented_articles, through: :comments, source: :article

  attr_accessor :remember_token
  before_save { self.email = email.downcase }

  # ----- バリデーション -----
  validates :name, presence: true, length: { maximum: 20 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

  # ----- -----

  has_secure_password
  mount_uploader :image, ImagesUploader

  # ----- 関数一覧 -----

  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end

    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update(remember_digest: User.digest(remember_token))
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update(remember_digest: nil)
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  # --------------------------------------------------------------------
  # has_secure_passwordメソッドではpassword_digestとの検証を行う
  # authenticateメソッドが提供されるが、それ以外の属性の認証を行うための
  # メソッドを作成
  # --------------------------------------------------------------------
  def authenticated?
    # サイトアクセス時は、ヘッダーのnav表示判断用にcurrent_user メソッドが
    # 必ず実行される。
    # 別ブラウザ等ですでにログアウトしていたら、remember_digest = nil
    # となっているためにメソッド内2行目の処理が失敗してしまうため、
    # falseを返し、current_user = nil(ログインしていない状態)とする必要がある。
    return false if remember_digest.nil?

    Bcrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ストック関連
  def stock(article)
    stocked_articles << article
  end

  def unstock(article)
    stocks.find_by(stocked_article_id: article.id).destroy
  end

  # いいね関連
  def add_like(article)
    liked_articles << article
  end

  def remove_like(article)
    likes.find_by(liked_article_id: article.id).destroy
  end

  # 通知機能関連
  def update_last_access_time
    update(last_access_time: Time.zone.now.to_s(:custom))
  end
end
