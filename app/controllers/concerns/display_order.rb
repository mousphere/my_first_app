# frozen_string_literal: true

module DisplayOrder
  extend ActiveSupport::Concern

  private

  # 記事表示順選択用オプションをセット
  def set_option
    if current_user
      current_user.update(order_option: params[:option]) if params[:option]
      current_user.order_option
    else
      # ログインしていない時はオプションをセッションに格納
      session[:not_logged_in] = 0                    if session[:not_logged_in].nil?
      session[:not_logged_in] = params[:option].to_i if params[:option]
      session[:not_logged_in]
    end
  end

  def display_order_change(option, per, genre)
    articles = if genre.present?
                 Article.where(genre: genre)
               else
                 Article.all
               end

    if option.zero?
      @articles = articles.page(params[:page]).per(per).order(created_at: :desc)
    elsif option == 1
      @articles = articles.page(params[:page]).per(per).order(like_counts: :desc)
    end
  end
end
