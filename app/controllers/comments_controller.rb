# frozen_string_literal: true

class CommentsController < ApplicationController
  include Common

  before_action :logged_in_user, only: %i[new create]
  before_action :correct_comment_user, only: %i[destroy]

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

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'コメントが削除されました'
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def correct_comment_user
    @comment = Comment.find(params[:id])
    return if current_user?(@comment.user)

    flash[:danger] = 'アクセス権がありません'
    redirect_to root_url
  end
end
