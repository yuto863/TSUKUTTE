class CommentsController < ApplicationController
  
  def new
    
  end
  

  def create
    @post = Post.find(params[:post_id])
    
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    
    if @comment.save
      flash[:notice] = '投稿が完了しました'
      redirect_to post_path(@comment.post.id)
    else
      flash[:notice] = '投稿に失敗しました'
      redirect_to post_path(@comment.post.id)
    end
  end
  
  private
    def comment_params
      params.require(:comment).permit(:content,:post_id)
    end
end
