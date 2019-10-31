# frozen_string_literal: true

class UsersController < ApplicationController
  include Common

  before_action :logged_in_user, only: %i[edit update deactivate destroy stocks]
  before_action :correct_user, only: %i[edit update deactivate destroy]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    if current_user?(@user)
      @user.update_last_access_time unless @user.next_last_access_time.nil?
      @user.update_next_last_access_time
    end

    @articles = @user.articles
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '登録が完了しました！みんなで観光地を共有しましょう！'
      redirect_to user_path(@user)
    else
      render '/users/new'
    end
  end

  def deactivate
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'アカウントが削除されました'
    redirect_to root_url
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
    @likes = Like.where(liked_article_id: Article.select(:id)
                 .where(user_id: params[:id]))
    # @users = User.where(id: Like.select(:like_user_id)
    #                   .where(liked_article_id: Article.select(:id)
    #                   .where(user_id: params[:id])))
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
end
