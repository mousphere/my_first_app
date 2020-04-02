# frozen_string_literal: true

class StaticPagesController < ApplicationController
  include DisplayOrder

  PER = 10

  def home
    session[:for_article_show] = 0

    option = set_option
    genre ||= params[:genre]

    display_order_change(option, PER, genre)

    @q = Article.ransack(params[:q])
    # @articles = @q.result.page(params[:page]).per(PER).order(created_at: :desc)

    respond_to do |format|
      format.html {}
      format.json { render json: nil }
    end
  end
end
