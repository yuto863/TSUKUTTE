class UsersController < ApplicationController
  before_action :logged_in_user, only:[:edit,:update]
  before_action :correct_user,   only:[:edit,:update]
  
  def index
    @users = User.all.order(created_at: :desc)
  end
  
  def show
    @user = User.find_by(id: params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:notice] = "ユーザーを作成いたしました"
      redirect_to users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザーの編集が完了しました"
      redirect_to user_path
    else
      render :edit
    end
  end
  
  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id).order(updated_at: :desc)
    
  end
  
  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:notice] = 'ユーザーを削除しました'
    redirect_to root_path
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email,:profile,:password,:password_confirmation)
    end
    
    def logged_in_user
      unless logged_in?
      store_location
      flash[:notice] = "ログインをしてください"
      redirect_to login_path
      end
    end
    
    def correct_user
      @user = User.find_by(id: params[:id])
      redirect_to root_path unless current_user?(@user)
    end
    
end
