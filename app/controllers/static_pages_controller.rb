# frozen_string_literal: true

class StaticPagesController < ApplicationController
  include DisplayOrder

  before_action :use_turbolinks_visit_control

  PER = 5

  def home
    session[:for_article_show] = 0

    option = set_option
    display_order_change(option, PER)

    respond_to do |format|
      format.html {}
      format.json { render json: nil }
    end
  end

  private

  def use_turbolinks_visit_control
    @use_turbolinks_visit_control = true
  end
end
