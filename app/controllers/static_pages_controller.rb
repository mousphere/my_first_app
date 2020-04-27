# frozen_string_literal: true

class StaticPagesController < ApplicationController
  PER = 10

  def home
    genre ||= params[:genre]
    prefecture ||= params[:prefecture]
    @q = Article.ransack(params[:q])

    articles = Article.choose(genre, prefecture, @q)

    option = set_option

    @articles = Article.order_arrange_by_option(articles, params[:page], PER, option)

    respond_to do |format|
      format.html {}
      format.json { render json: nil }
    end
  end

  private

  # 記事表示順選択用オプションをセット
  def set_option
    session[:option] = 0                    if session[:option].nil?
    session[:option] = params[:option].to_i if params[:option]
    session[:option]
  end
end
