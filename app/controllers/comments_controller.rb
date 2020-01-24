# frozen_string_literal: true

class CommentsController < ApplicationController
  include Common

  before_action :logged_in_user

  def new
    @comment = Comment.new
    @article = Article.find(params[:article_id])
  end
  
  def create
    @comment = current_user.comments.build(comment_params)
  end
  
  private

  def article_params
    params.require(:comment).permit(:content, :user_id, :article_id)
  end
end
