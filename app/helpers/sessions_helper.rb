module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # ユーザーのセッションを永続的にする
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  # 永続的セッションを破棄する
  # -----------------------------
  # 永続的セッション（クッキーを用いたセッション管理）を終了するには
  # サーバー側とクライアント側が持つ情報両方消去する必要がある
  # -----------------------------
  
  def forget(user)
    # Webサーバー側が保持している情報（remember_digest)を消去
    user.forget
    # クライアント側が保持しているクッキーを消去
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  def log_out
    # 永続的セッションを利用していた場合の処理
    forget(current_user)
    # 永続的セッション、一時セッション、どちらでも最終的に
    # セッションを削除してログアウトが完了する
    session.delete(:user_id)
  end
end
