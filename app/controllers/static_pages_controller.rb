# frozen_string_literal: true

class StaticPagesController < ApplicationController
  include DisplayOrder

  PER = 5

  def home
    session[:for_article_show] = 0

    option = set_option
    genre ||= params[:genre]

    display_order_change(option, PER, genre)

    respond_to do |format|
      format.html {}
      format.json { render json: nil }
    end
  end
end
