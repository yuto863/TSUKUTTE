class PostsController < ApplicationController
  before_action :logged_in_user, only:[:edit,:update]
  before_action :ensure_correct_user,{only: [:edit,:update,:destroy]}
  
  
  include ApplicationHelper
  


  
  def index
    @posts = Post.all
    @posts = Post.search(params[:search]).order(created_at: :desc)

    
  end
  
  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
    @comment = Comment.new
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(content: params[:post][:content],
                     title: params[:post][:title],
                     user_id: current_user.id
            )
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to posts_path
    else
      render :new
    end
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:post][:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to posts_path
    else
      render :edit
    end
  end
  

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    
    redirect_to posts_path
  end
  
  private
    def ensure_correct_user
      @post = Post.find_by(id: params[:id])
      if @post.user_id != current_user.id
        flash[:notice] = '権限がありません'
        redirect_to posts_path
      end
    end
    
    def logged_in_user
      unless logged_in?
      store_location
      flash[:notice] = "ログインをしてください"
      redirect_to login_path
      end
    end

  
end
