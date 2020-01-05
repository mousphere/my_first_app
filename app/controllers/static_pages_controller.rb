# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    if current_user
      current_user.update(order_option: params[:option]) if params[:option]
      option = current_user.order_option
    else
      set_option_in_session
      option = session[:not_logged_in]
    end

    display_order_change(option)

    respond_to do |format|
      format.html { render 'static_pages/home' }
      format.json { render json: nil }
    end
  end

  private

  def display_order_change(option)
    if option.zero?
      @articles = Article.order(created_at: :desc)
    elsif option == 1
      @articles = Article.order(like_counts: :desc)
    end
  end

  def set_option_in_session
    session[:not_logged_in] = 0                    if session[:not_logged_in].nil?
    session[:not_logged_in] = params[:option].to_i if params[:option]
  end
end
