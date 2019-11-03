# frozen_string_literal: true

class ArticlesController < ApplicationController
  include Common

  before_action :logged_in_user, only: %i[new create]

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = '記事を投稿しました！'
      redirect_to user_path(current_user)
    else
      render '/articles/new'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.where(genre: params[:genre])
    render '/static_pages/home'
  end

  private

  def article_params
    params.require(:article).permit(:sweet_name, :genre, :content, :image)
  end
end
