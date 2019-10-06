module Common
  extend ActiveSupport::Concern

  private
    def logged_in_user
      unless logged_in?
      flash[:danger] = 'ログインが必要です'
      redirect_to root_url
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:danger] = 'アクセス権がありません'
        redirect_to root_url
      end
    end
end