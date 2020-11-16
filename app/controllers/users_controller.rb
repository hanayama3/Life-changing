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
 @user = User.find_by(id: params[:id])
end

def complete
@user = User.find_by(id: params[:id])
before_level = @user.level
habit_id = (complete_params).values.flatten.compact.reject(&:empty?)
unless habit_id.empty?
@habit = Habit.find(habit_id)
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
  params.require(:user).permit(habit_ids: [])
end

end

