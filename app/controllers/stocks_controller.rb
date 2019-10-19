# frozen_string_literal: true

class StocksController < ApplicationController
  def create
    @article = Article.find(params[:stocked_article_id])
    @stock = current_user.stock(@article)
    
    respond_to do |format|
      format.html { redirect_to @article }
      format.json { render json: current_user.stocks.find_by(stocked_article_id: @article.id) }
    end
  end
  
  def destroy
    @article = Stock.find(params[:id]).stocked_article
    current_user.unstock(@article)
    respond_to do |format|
      format.html { redirect_to @article }
      format.json { render json: nil }
    end
  end
end