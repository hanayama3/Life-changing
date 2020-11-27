class PostsController < ApplicationController
 include LoginUser
   before_action :redirect_root
   
  def index
    @posts = Post.where(private: false).page(params[:page]).per(9)
  end
  
  def new
    @post = Post.new
  end
 
  def create
     @post = Post.new(post_params)
     if @post.save
        flash[:notice] = "投稿しました"
        redirect_to @post.user
    else
     render "new"
  end
  end
  
  def private
    @user = User.find(params[:id])
    @private_posts = @user.posts.where(private: true).page(params[:page]).per(9)
  end
  
   def destroy
     @post = Post.find(params[:id])
     @post.destroy
     flash[:notice] = "投稿を削除しました"
     redirect_to @post.user
  end
  
  
 private
 
 def post_params
     params.require(:post).permit(:content, :private, :user_id)
 end
  
end
