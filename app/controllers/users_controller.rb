class UsersController < ApplicationController
  include LoginUser
  before_action :set_user, except: [:index]
  before_action :redirect_root
  
  def index
    @users = User.order(level: "desc").page(params[:page]).per(12)
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
end

def complete
 before_level = @user.level
  @habit = Habit.find(complete_params)
  @habit.each do |habit|
  habit.update(complete: habit.complete += 1)
  @user.update(level: @user.level += 1)
  flash[:notice] = "達成！"
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

end

