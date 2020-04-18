# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    if params[:for_test]
      log_in_as_test_user
    elsif params[:session]
      user = User.find_by(email: params[:session][:email].downcase)
      log_in_with_mail_address(user)
    else
      user_data = request.env['omniauth.auth']
      user = User.find_by(uid: user_data[:uid])
      log_in_with_twitter_account(user, user_data)
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def log_in_with_mail_address(user)
    if user &.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user_path(user)
    else
      flash.now[:danger] = 'メールアドレス、もしくはパスワードの入力が正しくありません'
      render '/sessions/new'
    end
  end

  def log_in_with_twitter_account(user, user_data)
    if user
      user.update_twitter_info(user_data)
      log_in user
      redirect_to user_path(user)
    else
      new_user = User.create_by_twitter_account_info(user_data)
      if new_user.save
        log_in new_user
        flash[:success] = 'ユーザー登録に成功しました'
        redirect_to user_path(new_user)
      else
        flash[:danger] = '予期せぬエラーが発生しました'
        render '/sessions/new'
      end
    end
  end
end
