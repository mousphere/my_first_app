# frozen_string_literal: true

class LikesController < ApplicationController
  include Common

  before_action :logged_in_user

  def create
    @article = Article.find(params[:liked_article_id])
    @like = current_user.add_like(@article)
    @like_count = Like.where(liked_article_id: @article.id).count

    respond_to do |format|
      format.html { redirect_to @article }
      format.json { render json: { like: current_user.likes.find_by(liked_article_id: @article.id), count: @like_count } }
    end
  end

  def destroy
    @article = Like.find(params[:id]).liked_article
    current_user.remove_like(@article)
    @like_count = Like.where(liked_article_id: @article.id).count

    respond_to do |format|
      format.html { redirect_to @article }
      format.json { render json: { like: nil, count: @like_count } }
    end
  end
end
