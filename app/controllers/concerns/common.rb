# frozen_string_literal: true

module Common
  extend ActiveSupport::Concern

  private

  def logged_in_user
    return if logged_in?

    flash[:danger] = 'ログインが必要です'
    redirect_to root_url
  end

  def correct_user
    @user = User.find(params[:id])
    return if current_user?(@user)

    flash[:danger] = 'アクセス権がありません'
    redirect_to root_url
  end
end
