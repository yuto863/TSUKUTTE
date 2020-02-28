class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to root_path,info: 'すでにログインしています'
    end
  end
  
  def create
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or_to user
        flash[:success]='ログインしました'
      else
        flash.now[:danger]='パスワードかメールアドレスが間違っています'
        render :new
      end
  end
  
  def destroy
    log_out  if logged_in?
    redirect_to root_url,success: 'ログアウトしました'
  end
  

end
