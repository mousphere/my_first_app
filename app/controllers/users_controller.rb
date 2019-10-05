class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :deactivate, :destroy]
  before_action :correct_user, only: [:edit, :update, :deactivate, :destroy]
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @articles = @user.articles
    #@articles = @user.articles.paginate(page: params[:page])
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '登録が完了しました！みんなで観光地を共有しましょう！'
      redirect_to user_path(@user)
    else
      render '/users/new'
    end
  end
  
  def deactivate
     @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'アカウントが削除されました'
    redirect_to root_url
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params_including_image)
      flash[:success] = 'プロフィールが更新されました'
      redirect_to @user
    else
      render '/users/edit'
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email,
                                   :password, :password_confirmation)
    end
    
    # TODO
    # 新規登録時も以下に更新する?
    def user_params_including_image
      params.require(:user).permit(:name, :email,
                                   :password, :password_confirmation, :image)
    end
    
    # before アクション
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
