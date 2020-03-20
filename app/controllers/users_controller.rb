# frozen_string_literal: true

class UsersController < ApplicationController
  include Common

  before_action :logged_in_user, only: %i[edit update deactivate destroy stocks notify]
  before_action :correct_user, only: %i[edit update deactivate destroy notify]

  def new
    @user = User.new
  end

  def show
    session[:for_article_show] = 1

    @user = User.find(params[:id])
    @articles = @user.articles.order(created_at: :desc)
    @title = '作成記事一覧'
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '登録が完了しました！あなたのおすすめスイーツを共有しましょう！'
      redirect_to user_path(@user)
    else
      render '/users/new'
    end
  end

  def deactivate
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if @user.for_test
      flash[:danger] = 'テストユーザーは削除できません'
      redirect_back(fallback_location: root_path)
    else
      @user.destroy
      flash[:success] = 'アカウントが削除されました'
      redirect_to root_url
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params_including_image)
      flash[:success] = 'プロフィールが更新されました'
      redirect_to @user
    else
      render '/users/edit'
    end
  end

  def stocks
    @articles = Article.where(id: Stock.select(:stocked_article_id)
                       .where(stock_user_id: params[:id]))
  end

  def notify
    update_access_time

    @likes = Like.where(liked_article_id: Article.select(:id)
                 .where(user_id: params[:id])).order(created_at: :desc)
  end

  def followings
    @users = User.find(params[:id]).followings.all
    @title = 'フォロー中'
    render '/users/follow'
  end

  def followers
    @users = User.find(params[:id]).followers.all
    @title = 'フォロワー'
    render '/users/follow'
  end

  def followings_articles
    @user = User.find(params[:id])
    @articles = Article.where(user_id: Relationship.select(:followed_id)
                       .where(follower_id: @user.id)).order(created_at: :desc)
    @title = 'フォローユーザー記事一覧'
    render '/users/show'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email,
                                 :password, :password_confirmation)
  end

  # TODO
  # 新規登録時も以下に更新する?
  def user_params_including_image
    params.require(:user).permit(:name, :email,
                                 :password, :password_confirmation, :image)
  end

  def update_access_time
    @user = User.find(params[:id])
    @user.update_last_access_time if current_user?(@user)
  end
end
