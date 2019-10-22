# frozen_string_literal: true

class LikesController < ApplicationController
  include Common

  before_action :logged_in_user

  def create
    @article = Article.find(params[:liked_article_id])
    @like = current_user.add_like(@article)

    respond_to do |format|
      format.html { redirect_to @article }
      format.json { render json: current_user.likes.find_by(liked_article_id: @article.id) }
    end
  end

  def destroy
    @article = Like.find(params[:id]).liked_article
    current_user.remove_like(@article)
    respond_to do |format|
      format.html { redirect_to @article }
      format.json { render json: nil }
    end
  end
end
