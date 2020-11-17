class PostsController < ApplicationController
#   include NotLogged
   before_action :redirect_root
   
  def index
    @posts = Post.where(private: false)
  end
  
  def destroy
  end
  
  def private
    @user = User.find(params[:id])
    @private_post = @user.posts.where(private: true)
  end
  
#   private
  
 def redirect_root
  if current_user.nil?
  flash[:notice] = "ログインしてください"
  redirect_to root_path
end
end
  
end
