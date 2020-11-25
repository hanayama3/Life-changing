class PostsController < ApplicationController
 include LoginUser
   before_action :redirect_root
   
  def index
    @posts = Post.where(private: false).page(params[:page]).per(9)
  end
  
  def destroy
     @post = Post.find(params[:id])
     @post.destroy
     flash[:notice] = "投稿を削除しました"
     redirect_to @post.user
  end
  
  def private
    @user = User.find(params[:id])
    @private_posts = @user.posts.where(private: true).page(params[:page]).per(9)
  end
end
