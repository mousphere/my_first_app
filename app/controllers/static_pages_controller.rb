# frozen_string_literal: true

class StaticPagesController < ApplicationController
  include DisplayOrder

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
end
