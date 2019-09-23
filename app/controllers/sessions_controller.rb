class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user) 
      redirect_to user_path(user)
    else
      flash.now[:danger] = 'メールアドレス、もしくはパスワードの入力が正しくありません'
      render '/sessions/new'
    end
  end
  
  def destroy
    # すでに別のタブでログアウトが完了していたら、再度ログアウト処理は行わない
    log_out if logged_in?
    redirect_to root_url
  end
end