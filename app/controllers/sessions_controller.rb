# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    if params[:for_test]
      log_in_as_test_user
    elsif params[:session][:email]
      user = User.find_by(email: params[:session][:email].downcase)
      if user &.authenticate(params[:session][:password])
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to user_path(user)
      else
        flash.now[:danger] = 'メールアドレス、もしくはパスワードの入力が正しくありません'
        render '/sessions/new'
      end
    else
      user_data = request.env['omniauth.auth']
      user = User.find_by(uid: user_data[:uid])
      if user
        log_in user
        redirect_to user_path(user)
      else
        new_user = User.new(
          name: user_data[:info][:name],
          email: User.dummy_email(user_data[:uid]),
          password_digest: User.digest(SecureRandom.alphanumeric(8)),
          for_test: false,
          uid: user_data[:uid],
          remote_image_url: user_data[:info][:image]
        )
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

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
