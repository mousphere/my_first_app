class ArticlesController < ApplicationController
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
  
  private
    def article_params
      params.require(:article).permit(:sweet_name, :genre, :content, :image)
    end
end
