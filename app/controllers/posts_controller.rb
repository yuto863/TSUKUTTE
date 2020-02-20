class PostsController < ApplicationController
  before_action :logged_in_user, only:[:edit,:update]
  before_action :ensure_correct_user,{only: [:edit,:update,:destroy]}
  
  
  include ApplicationHelper
  


  
  def index
    # 最新の投稿日時を表示させる
    @posts = Post.all.order(created_at: :desc)
    
    # 全てのいいねランキング
    # @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
    
    # 期間別のいいねランキング
    # @posts_trend_day = Post.find(Like.where('created_at > ?', 1.day.ago).group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
    # @posts_trend_week = Post.find(Like.where('created_at > ?', 1.week.ago).group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
    # @posts_trend_month = Post.find(Like.where('created_at > ?', 1.month.ago).group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
    
    
    # 日、週、月ごとに集計し、いいね数順に表示させる
    # できなかったやつ
    # @likes = Like.where('created_at > ?', 1.day.ago)
    # @posts_trend_day = Post.joins(:like).order("count(@like.id) DESC")
    
    # @likes_day= Like.where('created_at > ?', 1.day.ago)
    # @post_day=Post.where('created_at > ?', 1.day.ago)
    # @day_ranks = Post.where('created_at > ?', 1.day.ago).find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
   
    
  end
  
  def show
    @post = Post.find(params[:id])
    @user = User.find_by(id: @post.user_id)
    @comment = Comment.new
  end
  
  def new
    @post = Post.new
  end
  
  def create
    # @post = Post.new(post_params)
    # if @post.save
    #   flash[:notice] = "投稿が完了しました"
    #   redirect_to user_path
    # else
    #   render :new
    # end
    
    if @post = Post.create(content: params[:post][:content],
                           title: params[:post][:title],
                           user_id: current_user.id
                          )
    
      # flash[:notice] = "投稿を作成しました"
      redirect_to posts_path,success: '投稿を作成しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
    
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.content = params[:post][:content]
    @post.title = params[:post][:title]
    if @post.save
      # flash[:notice] = "投稿を編集しました"
      redirect_to posts_path,success: '投稿を編集しました'
    else
      flash.now[:danger] = "編集に失敗しました"
      render :edit
    end
  end
  

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    
    # flash[:notice] = '削除されました'
    redirect_to posts_path,success: '削除されました'
  end
  
  def search
    @posts = Post.all
    @posts = Post.search(params[:search]).order(created_at: :desc)
    
  end
  
  def posts_trend_day
    @posts_trend_day = Post.find(Like.where('created_at > ?', 1.day.ago).group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
  end
  
  def posts_trend_week
    @posts_trend_week = Post.find(Like.where('created_at > ?', 1.week.ago).group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
  end
  
  def posts_trend_month
    @posts_trend_month = Post.find(Like.where('created_at > ?', 1.month.ago).group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
  end
  
  def all_ranks
    @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
  end
  
  
  
  private
    # def post_params
    #   params.require(:post).permit(:title, :content,:user_id)
    # end
    
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
