class PostsController < ApplicationController
  def index
    @posts = Post.where(private: false)
  end
  
  def destroy
  end
  
  def private
    @user = User.find_by(id: params[:id])
    @private_post = @user.posts.where(private: true)
  end
  
end
