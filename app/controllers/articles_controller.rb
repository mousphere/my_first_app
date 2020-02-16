# frozen_string_literal: true

class ArticlesController < ApplicationController
  include Common
  include DisplayOrder
  PER = 5

  before_action :logged_in_user, only: %i[new create edit update destroy]
  before_action :correct_article_user, only: %i[edit update destroy]

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
    @comments = Comment.where(article_id: params[:id]).order(created_at: :desc)

    if session[:for_article_show].zero?
      render '/articles/show_with_category'
    else
      render '/articles/show_with_user_func'
    end

    return unless params[:like_id]

    @like = Like.find(params[:like_id])
    @like.change_checked?
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = '記事が更新されました'
      redirect_to @article
    else
      render '/articles/edit'
    end
  end

  def index
    session[:for_article_show] = 0

    option = set_option
    display_order_change(option, PER, params[:genre])

    respond_to do |format|
      format.html { render 'static_pages/home' }
      format.json { render json: nil }
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:success] = '記事が削除されました'
    redirect_back(fallback_location: root_path)
  end

  private

  def article_params
    params.require(:article).permit(:sweet_name, :genre, :content, :image)
  end

  def correct_article_user
    @article = Article.find(params[:id])
    return if current_user?(@article.user)

    flash[:danger] = 'アクセス権がありません'
    redirect_to root_url
  end
end
