class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = '登録が完了しました！みんなで観光地を共有しましょう！'
      redirect_to user_path(@user)
    else
      render '/users/new'
    end
  end

  def delete
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email,
                                   :password, :password_confirmation)
    end
end
