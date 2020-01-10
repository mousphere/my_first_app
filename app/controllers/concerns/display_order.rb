# frozen_string_literal: true

module DisplayOrder
  extend ActiveSupport::Concern

  private

  def display_order_change(option, per)
    if option.zero?
      @articles = Article.page(params[:page]).per(per).order(created_at: :desc)
    elsif option == 1
      @articles = Article.page(params[:page]).per(per).order(like_counts: :desc)
    end
  end

  # ログインしていない時に記事表示順を切り替える用の
  # パラメータをセッションに格納
  def set_option_in_session
    session[:not_logged_in] = 0                    if session[:not_logged_in].nil?
    session[:not_logged_in] = params[:option].to_i if params[:option]
  end
end
