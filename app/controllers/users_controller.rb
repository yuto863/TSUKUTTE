class UsersController < ApplicationController
  before_action :logged_in_user, only:[:edit,:update]
  before_action :correct_user,   only:[:edit,:update]
  
  # def index
  #   @users = User.all.order(created_at: :desc)
  # end
  
  def show
    # usernameにしたい
    # @user = User.find_by(name: params[:id])
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      # flash[:notice] = "ユーザーを作成いたしました"
      redirect_to root_path, success: '登録が完了しました。'
    else
      flash.now[:danger] = "登録に失敗しました。入力した値が正しいかご確認ください。"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      # flash[:notice] = "ユーザーの編集が完了しました"
      redirect_to user_path,success: 'ユーザーの編集が完了しました'
    else
      flash.now[:danger] = "ユーザーの編集に失敗しました"
      render :edit
    end
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = Like.where(user_id: @user.id).order(updated_at: :desc)
  end
  
  def comments
    @user = User.find(params[:id])
    @comments = Comment.where(user_id: @user.id).order(updated_at: :desc)
  end
  
  def destroy_confirm
    # たぶんこれいらない
    # @leave_reason = LeaveReason.new
  end
  
  def destroy
    @leave_reason = LeaveReason.create(content: params[:content])
    # @user = User.find(params[:id])
    @user = User.find(current_user.id)
    @user.destroy
    # flash[:notice] = 'ユーザーを削除しました'
    redirect_to root_path,info: 'ユーザー退会を完了いたしました。またのご利用をお待ちしております。'
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email,:profile,:password,:password_confirmation,:image)
    end
    
    def logged_in_user
      unless logged_in?
      store_location
      # flash[:notice] = "ログインをしてください"
      redirect_to login_path,success: 'ログインしてください'
      end
    end
    
    def correct_user
      @user = User.find_by(id: params[:id])
      redirect_to root_path unless current_user?(@user)
    end

end
