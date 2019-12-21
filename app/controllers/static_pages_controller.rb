# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    if current_user
      current_user.update(order_option: params[:option]) if params[:option]
      display_order_change(current_user.order_option)
    else
      # notLoginOption テーブル（ログインしていない時に使用したいデータを保存するDB）
      # のorder_option を参照する
      @articles = Article.order(created_at: :desc)
    end

    respond_to do |format|
      format.html { render 'static_pages/home' }
      format.json { render json: nil }
    end
  end

  private

  def display_order_change(option)
    if option.zero?
      @articles = Article.order(created_at: :desc)
    elsif option == 1
      @articles = Article.order(like_counts: :desc)
    end
  end
end
