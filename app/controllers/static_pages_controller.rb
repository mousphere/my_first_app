# frozen_string_literal: true

class StaticPagesController < ApplicationController
  include DisplayOrder

  before_action :no_use_turbolinks_cache
  # before_action :set_cache_buster
  PER = 5

  def home
    # expires_now
    session[:for_article_show] = 0

    if current_user
      current_user.update(order_option: params[:option]) if params[:option]
      option = current_user.order_option
    else
      set_option_in_session
      option = session[:not_logged_in]
    end

    display_order_change(option, PER)

    respond_to do |format|
      format.html {}
      format.json { render json: nil }
    end
  end
  
  private
  def set_cache_buster
    response.headers["Cache-Control"] = "no-store"
    response.headers["Pragma"] = "no-store"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
