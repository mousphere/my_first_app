# frozen_string_literal: true

class CommentsController < ApplicationController
  include Common

  before_action :logged_in_user

  def new
    @comment = Comment.new
    @article = Article.find(params[:article_id])
  end

  def create
    @article = Article.find(params[:article_id])

    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.article_id = @article.id

    if @comment.save
      flash[:success] = 'コメントを投稿しました！'
      redirect_to @article
    else
      render '/comments/new'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
