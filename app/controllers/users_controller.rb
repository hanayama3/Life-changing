class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def following
    @title = "フォロー"
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end
  
  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end
  
def mission
 @user = User.find(params[:id])
 @post = @user.posts.new
end

def complete
@user = User.find(params[:id])
if (post_params)
@post = @user.posts.new(post_params)
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

def complete_params
  params.require(:user).permit(habit_ids: []).values.flatten.compact.reject(&:empty?)
end

def post_params
  params.require(:user).permit(:content, :private)
end

end

