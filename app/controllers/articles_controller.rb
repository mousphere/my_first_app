class ArticlesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @article = Article.new
  end
end
