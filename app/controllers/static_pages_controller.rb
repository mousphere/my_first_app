# frozen_string_literal: true

class StaticPagesController < ApplicationController
  PER = 10

  def home
    session[:for_article_show] = 0

    genre ||= params[:genre]
    @q = Article.ransack(params[:q])

    articles = Article.choose(genre, @q)

    option = set_option

    if option.zero?
      @articles = articles.page(params[:page]).per(PER).order(created_at: :desc)
    elsif option == 1
      @articles = articles.page(params[:page]).per(PER).order(like_counts: :desc)
    end

    respond_to do |format|
      format.html {}
      format.json { render json: nil }
    end
  end

  private

  # 記事表示順選択用オプションをセット
  def set_option
    if current_user
      current_user.update(order_option: params[:option]) if params[:option]
      current_user.order_option
    else
      # ログインしていない時はオプションをセッションに格納
      session[:not_logged_in] = 0                    if session[:not_logged_in].nil?
      session[:not_logged_in] = params[:option].to_i if params[:option]
      session[:not_logged_in]
    end
  end
end
