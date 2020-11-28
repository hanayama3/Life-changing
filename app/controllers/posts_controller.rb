class PostsController < ApplicationController
 include LoginUser
   before_action :redirect_root
   
  def index
    @title = "みんなの投稿"
    @posts = Post.where(private: false).page(params[:page]).per(8)
  end
  
   def follow_users
     @title = "フォロー中のユーザー"
     @user = User.find(params[:id])
     @posts = Post.where(private: false).where(user_id: [@user.id, *@user.following_ids]).page(params[:page]).per(8)
  end
  
  
  def new
    @post = Post.new
  end
 
  def create
     @post = Post.new(post_params)
     if @post.save
        flash[:notice] = "投稿しました"
        redirect_to posts_path
    else
     render "new"
  end
  end
  
 
  
  def private
    @user = User.find(params[:id])
    unless @user == current_user
    flash[:alert] = "他のユーザーの非公開投稿は見れません"
    redirect_to root_url
    else
    @private_posts = @user.posts.where(private: true).page(params[:page]).per(9)
  end
  end
  
   def destroy
     @post = Post.find(params[:id])
     @post.destroy
     flash[:notice] = "投稿を削除しました"
     redirect_to posts_path
  end
  
  
 private
 
 def post_params
     params.require(:post).permit(:content, :private, :user_id)
 end

end
