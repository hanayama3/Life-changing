class UsersController < ApplicationController
  include LoginUser
  before_action :set_user, only: [:show,:following,:followers,:mission, :complete]
  before_action :redirect_root
  
  def index
    @users = User.all
  end
  
  def show
  end
  
  def following
    @title = "フォロー"
    @users = @user.following
    render 'show_follow'
  end
  
  def followers
    @title = "フォロワー"
    @users = @user.followers
    render 'show_follow'
  end
  
def mission
 @post = @user.posts.new
end

def complete
unless (post_params).nil?
@post = @user.posts.new(post_params)
flash[:notice] = "投稿しました"
@post.save!
end

 before_level = @user.level
 unless complete_params.empty?
  @habit = Habit.find(complete_params)
  @habit.each do |h|
  h.update_attributes(complete: h.complete += 1)
  @user.update_attributes(level: @user.level += 1)
  flash[:notice] = "達成！"
end
end
@user.record(before_level)
redirect_to @user
end

private

def set_user
  @user = User.find(params[:id])
end

def complete_params
  params.require(:user).permit(habit_ids: []).values.flatten.compact.reject(&:empty?)
end

def post_params
  unless params[:user][:content].empty?
  params.require(:user).permit(:content, :private)
else
  return nil
  end
end

end

