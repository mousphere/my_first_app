class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  
  # ----- バリデーション -----
  validates :name, presence: true, length: { maximum: 20 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
  
  # ----- -----
  
  has_secure_password
  mount_uploader :image, ImagesUploader
  
  # ----- 関数一覧 -----
  
  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                 BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
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
    Bcrypt::Password.new(self.remember_digest).is_password?(remember_token)
  end
end
